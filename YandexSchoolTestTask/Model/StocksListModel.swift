//
//  StocksList.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 12.03.2021.
//

import Foundation

protocol StocksListModelDelegate: class {
    func reloadItem(at index: IndexPath)
}

final class StocksListModel {
    var indices: [String]?
    var profiles: [StockProfile]?
    var stocksMap: [String: StockProfile?]
    var favorites: Set<String>
    
    init() {
        stocksMap = [String: StockProfile]()
        favorites = Set<String>()
    }
    
    func setProfile(for symbol: String,_ profile: StockProfile) {
        stocksMap[symbol] = profile
    }
}
