//
//  Service.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 22.03.2021.
//

import Foundation
import ResourceNetworking

final class FakeReachability: ReachabilityProtocol {
    var isReachable: Bool = true
}

final class ResourceFactory {
    private func buildURL(_ baseURL: String,_ parameters: [String: Any]) -> URL? {
        guard let url = URL(string: baseURL) else { return nil }
        var com = URLComponents(url: url, resolvingAgainstBaseURL: false)
        com?.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: "\(value)")
            com?.queryItems?.append(item)
        }
        return com?.url
    }
    
    func createIndicesResource(_ symbol: String,_ token: String) -> Resource<IndicesResponse>? {
        let urlString = "https://finnhub.io/api/v1/index/constituents"
        let parameters = ["symbol": symbol, "token": token]
        
        guard let url = buildURL(urlString, parameters) else { return nil }

        return Resource<IndicesResponse>(url: url, headers: nil)
    }
    
    func createStockProfileResource(_ symbol: String, token: String) -> Resource<StockProfile>? {
        let urlString = "https://finnhub.io/api/v1/stock/profile2"
        let parameters = ["symbol": symbol, "token": token]
        
        guard let url = buildURL(urlString, parameters) else { return nil }
        
        return Resource<StockProfile>(url: url, headers: nil)
    }
    
    func createStockPriceResource(_ symbol: String, token: String) -> Resource<StockPrice>? {
        let urlString = "https://finnhub.io/api/v1/quote"
        let parameters = ["symbol": symbol, "token": token]
        
        guard let url = buildURL(urlString, parameters) else { return nil }
        
        return Resource<StockPrice>(url: url, headers: nil)
    }
    
    func createImageResource(_ url: String, token: String) -> Resource<Data>? {
        guard let url = URL(string: url) else { return nil }
        
        let parse: (Data) throws -> Data = { data in
            return data
        }
        
        return Resource<Data>(url: url, method: .get, parse: parse)
    }
}

final class Cancel {
    var cancelStockProfileLoad: Cancellation?
    var cancelStockPriceLoad: Cancellation?
    var cancelLoadStockImage: Cancellation?
}

final class StocksService {
    let networkHeler = NetworkHelper(reachability: FakeReachability())
    
    var token = "c0mml8v48v6tkq1360dg"
    //container with request references
    var requestContainer = [String: Cancel]()
    
    func loadStocksList(with symbol: String, completion: @escaping(OperationCompletion<IndicesResponse>) -> ()) {
        guard let resource = ResourceFactory().createIndicesResource(symbol, token) else {
            let error = NSError(domain: "stocks list load. smt went wrong", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        _ = load(with: symbol, resource: resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func loadStockProfile(with symbol: String, completion: @escaping(OperationCompletion<StockProfile>) -> ()) {
        guard let resource = ResourceFactory().createStockProfileResource(symbol, token: token) else {
            let error = NSError(domain: "stock profile load. smt went wrong", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        
        if requestContainer[symbol] == nil {
            requestContainer[symbol] = Cancel()
        }
        
        if requestContainer[symbol]!.cancelStockProfileLoad != nil {
            return
        }
        
        requestContainer[symbol]!.cancelStockProfileLoad = load(with: symbol, type: .profileLoad, resource: resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func loadStockPrice(with symbol: String, completion: @escaping(OperationCompletion<StockPrice>) -> ()) {
        guard let resource = ResourceFactory().createStockPriceResource(symbol, token: token) else {
            let error = NSError(domain: "stock profile load. error smt went wrong", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        if requestContainer[symbol] == nil {
            requestContainer[symbol] = Cancel()
        }
        
        if requestContainer[symbol]!.cancelStockPriceLoad != nil { return }
        
        requestContainer[symbol]!.cancelStockPriceLoad = load(with: symbol, type: .priceLoad, resource: resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func loadImage(with symbol: String, _ url: String, completion: @escaping(OperationCompletion<Data>) -> ()) {
        guard let resource = ResourceFactory().createImageResource(url, token: token) else {
            let error = NSError(domain: "load image error", code: 0, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        if requestContainer[symbol] == nil {
            requestContainer[symbol] = Cancel()
        }
        
        if requestContainer[symbol]!.cancelLoadStockImage != nil { return }
        
        requestContainer[symbol]!.cancelLoadStockImage = load(with: symbol, type: .imageLoad ,resource: resource, completion: { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func load<T>(with symbol: String, type: cancelTypes? = nil, resource: Resource<T>, completion: @escaping(OperationCompletion<T>) -> ()) -> Cancellation? {
        let cancel = networkHeler.load(resource: resource, completion: { [weak self] result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))

            }
            if type != nil {
                self?.endRequest(with: symbol, type: type!)
            }
        })
        return cancel
    }
    
    func cancelRequest(with symbol: String) {
        guard requestContainer[symbol] == nil else { return }
        requestContainer[symbol]?.cancelStockPriceLoad?.cancel()
        requestContainer[symbol]?.cancelStockProfileLoad?.cancel()
        requestContainer[symbol]?.cancelLoadStockImage?.cancel()
        
        requestContainer[symbol]?.cancelStockPriceLoad = nil
        requestContainer[symbol]?.cancelStockProfileLoad = nil
        requestContainer[symbol]?.cancelLoadStockImage = nil
    }
    
    private func endRequest(with symbol: String, type: cancelTypes) {
        switch type {
        case .priceLoad:
            requestContainer[symbol]?.cancelStockPriceLoad = nil
        case .profileLoad:
            requestContainer[symbol]?.cancelStockProfileLoad = nil
        case .imageLoad:
            requestContainer[symbol]?.cancelLoadStockImage = nil
        }
    }
}

enum cancelTypes {
    case priceLoad
    case profileLoad
    case imageLoad
}
