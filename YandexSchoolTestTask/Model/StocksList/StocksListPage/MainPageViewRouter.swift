//
//  MainPageViewRouter.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 12.03.2021.
//

import Foundation

final class MainPageViewRouter: MainPageViewRouterProtocol {
    weak var view: MainPageViewProtocol!
    
    init(with view: MainPageViewProtocol) {
        self.view = view 
    }
}
