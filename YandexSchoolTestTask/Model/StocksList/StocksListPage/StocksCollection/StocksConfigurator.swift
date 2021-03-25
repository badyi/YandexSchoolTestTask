//
//  StocksConfigurator.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 12.03.2021.
//

import Foundation

final class StocksConfigurator: StocksConfiguratorProtocol {
    func configurate(with view: StocksCollectionView, cvType: CollectionType) {
        let presenter = StocksPresenter(with: view, cvType: cvType)
        let router = StocksRouter(with: view)
        view.presenter = presenter
        presenter.router = router
    }
}
