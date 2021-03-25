//
//  StocksListPresenter.swift
//  YandexSchoolTest
//
//  Created by Бадый Шагаалан on 15.02.2021.
//

import Foundation
import ResourceNetworking

final class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol!
    var router: MainViewRouterProtocol!

    
    init(with view: MainViewProtocol) {
        self.view = view
    }
    
    func configurateView() {
        view.configView()
        view.configSearchBar()
        view.configPageVC()
        view.configBackView()
        view.configButtons()
    }
}
