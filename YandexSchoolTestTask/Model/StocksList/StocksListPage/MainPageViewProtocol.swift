//
//  StocksPageViewProtocol.swift
//  YandexSchoolTest
//
//  Created by Бадый Шагаалан on 27.02.2021.
//

import UIKit

protocol MainPageViewProtocol: class {
    func changeView(with index: Int)
    func sendModelToCollection(_ model: StocksListModel?)
}

protocol MainPageViewPresenterProtocol: class {
    func configurateView()
    func downloadStockIndices()
}

protocol MainPageViewConfiguratorProtocol: class {
    func configurate(with view: MainPageViewController)
}

protocol MainPageViewRouterProtocol: class {
    
}
