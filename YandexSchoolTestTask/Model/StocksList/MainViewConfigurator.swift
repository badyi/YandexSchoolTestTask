//
//  Configurator.swift
//  YandexSchoolTest
//
//  Created by Бадый Шагаалан on 15.02.2021.
//

import Foundation

final class MainViewConfigurator: MainViewConfiguratorProtocol {
    func configurate(with view: MainViewController) {
        let presenter = MainPresenter(with: view)
        let router = MainViewRouter(with: view)
        view.presenter = presenter
        presenter.router = router
    }
}
