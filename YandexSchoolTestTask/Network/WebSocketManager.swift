//
//  WebSoketManager.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 22.03.2021.
//

import Foundation

final class WSManager {
    static let shared = WSManager()
    let webSocketTask = URLSession(configuration: .default).webSocketTask(with: URL(string: "wss://ws.finnhub.io?token=c0mml8v48v6tkq1360dg")!)
    
    func connectToWebSocket() {
        webSocketTask.resume()
        self.reciveData {  }
    }
    
    func subscribe(_ symbol: String) {
        let dic: [String: String] = ["type": "subscribe", "symbol": symbol]
        let message = URLSessionWebSocketTask.Message.string(dic.jsonStringRepresentation!)
        webSocketTask.send(message) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func reciveData(completion: @escaping() -> Void) {
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("websocket reciving error, \(error)")
            case .success(let response):
                print(response)
                switch response {
                case .string(let text):
                    print(text)
                default:
                    print(response)
                }
                self.reciveData() { }
            }
        }
        
        completion()
    }
}

extension Dictionary {
    var jsonStringRepresentation: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }

        return String(data: theJSONData, encoding: .utf8)
    }
}

