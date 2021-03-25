//
//  StocksListProtocols.swift
//  YandexSchoolTest
//
//  Created by Бадый Шагаалан on 15.02.2021.
//

import UIKit

protocol MainViewConfiguratorProtocol: class {
    func configurate(with view: MainViewController)
}

protocol MainViewPresenterProtocol: class {
    func configurateView()
}

protocol MainViewProtocol: class{
    func configSearchBar()
    func configButtons()
    func configView()
    func configPageVC()
    func configBackView()
}

protocol MainViewDelegate: class {
    func viewChanged(_ index: Int)
}

protocol MainViewRouterProtocol: class {
    
}
