//
//  StocksListConfigurator.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 12.03.2021.
//

import Foundation

final class MainPageViewConfigurator: MainPageViewConfiguratorProtocol {
    func configurate(with view: MainPageViewController) {
        let presenter = MainPageViewPresenter(with: view)
        let router = MainPageViewRouter(with: view)
        view.presenter = presenter
        presenter.router = router
    }
}
