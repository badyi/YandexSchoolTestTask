//
//  StocksPresenter.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 12.03.2021.
//

import Foundation

final class StocksPresenter: StocksPresenterProtocol {
    weak var view: StocksViewProtocol!
    var router: StocksRouterProtocol!
    var type: CollectionType
    
    var service: StocksService!
    var model: StocksListModel?
    
    init(with view: StocksViewProtocol, cvType: CollectionType) {
        self.type = cvType
        self.view = view
        service = StocksService()
    }
    
    func configurateView() {
        view.configCollectionView()
    }
    
    func set(_ model: StocksListModel?) {
        self.model = model
        DispatchQueue.main.async {
            self.view.reloadData()
        }
    }
    
    func count() -> Int {
        switch type {
        case .favortie:
            return model?.favorites.count ?? 0
        case .deafult:
            return model?.indices?.count ?? 0
        }
    }
    
    func willDisplay(at index: IndexPath) {
        guard let model = model else { return }
        var symbol: String
        switch type {
        case .favortie:
            symbol = model.favorites[model.favorites.index(model.favorites.startIndex, offsetBy: index.row)]
        case .deafult:
            guard let sym = model.indices?[index.row]  else { return }
            symbol = sym
        }
        guard model.stocksMap[symbol] == nil else { return }
        
        service.loadStockProfile(with: symbol, completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.model?.stocksMap[symbol] = result
                self?.loadStockPrice(with: symbol, at: index)
                self?.loadStockImage(with: symbol, at: index)
                DispatchQueue.main.async {
                    self?.view.reloadItems(at: [index])
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func loadStockPrice(with symbol: String, at index: IndexPath) {
        service.loadStockPrice(with: symbol, completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.model?.stocksMap[symbol]?.optionalValue?.price = result
                DispatchQueue.main.async {
                    self?.view.reloadItems(at: [index])
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func loadStockImage(with symbol: String, at index: IndexPath) {
        guard let profile = model?.stocksMap[symbol] else { return }
        guard let logoUrl = profile?.logo else { return }
        
        service.loadImage(with: symbol, logoUrl, completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.model?.stocksMap[symbol]?.optionalValue?.imageData = result
                DispatchQueue.main.async {
                    self?.view.reloadItems(at: [index])
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func didEndDisplay(at index: IndexPath) {
        guard let symbol = model?.indices?[index.row] else { return }
        service.cancelRequest(with: symbol)
    }
    
    func profile(at index: IndexPath) -> StockProfile? {
        guard let symbol = model?.indices?[index.row] else { return nil }
        guard let profile = model?.stocksMap[symbol] else { return nil }
        return profile
    }
    
    func configFavorite(for symbol: String, at index: IndexPath) {
        model?.favorites.insert(symbol)
    }
    
    func isFavorite(at index: IndexPath) -> Bool {
        guard let profile = profile(at: index) else { return false }
        guard let model = self.model else { return false }
        let contains = model.favorites.contains(profile.ticker) 
        return contains
    }
}

extension StocksPresenter: StocksListModelDelegate {
    func reloadItem(at index: IndexPath) {
        DispatchQueue.main.async {
            self.view.reloadItems(at: [index])
        }
    }
}
