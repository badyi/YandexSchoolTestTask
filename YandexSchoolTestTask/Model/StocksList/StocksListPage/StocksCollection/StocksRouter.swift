//
//  StocksRouter.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 12.03.2021.
//

import Foundation

final class StocksRouter: StocksRouterProtocol {
    weak var view: StocksViewProtocol!
    
    init(with view: StocksViewProtocol) {
        self.view = view
    }
}
