//
//  StocksRouter.swift
//  YandexSchoolTest
//
//  Created by Бадый Шагаалан on 15.02.2021.
//

import UIKit

final class MainViewRouter: MainViewRouterProtocol {
    weak var view: MainViewProtocol!
    
    required init(with view: MainViewProtocol) {
        self.view = view
    }
}
