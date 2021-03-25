//
//  StocksProtocols.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 12.03.2021.
//

import Foundation

protocol StocksViewProtocol: class {
    func changeView(with index: Int)
    func configCollectionView()
    func reloadItems(at index: [IndexPath])
    func reloadData()
}

protocol StocksPresenterProtocol: class {
    func configurateView()
    func set(_ model: StocksListModel?)
    func count() -> Int
    func willDisplay(at index: IndexPath)
    func didEndDisplay(at index: IndexPath)
    func profile(at index: IndexPath) -> StockProfile?
    func loadStockPrice(with symbol: String, at index: IndexPath)
    func configFavorite(for symbol: String, at index: IndexPath)
    func isFavorite(at index: IndexPath) -> Bool
}

protocol StocksConfiguratorProtocol: class {
    func configurate(with view: StocksCollectionView, cvType: CollectionType)
}

protocol StocksRouterProtocol: class {
    
}

protocol StocksCellDelegate: class {
    func configFavorite(for symbol: String, at index: IndexPath)
}
