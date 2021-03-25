//
//  StocksListPagePresenter.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 12.03.2021.
//

import Foundation

final class MainPageViewPresenter: MainPageViewPresenterProtocol {
    weak var view: MainPageViewProtocol!
    var router: MainPageViewRouterProtocol!
    
    var service: StocksService!
    var model: StocksListModel?
    
    init(with view: MainPageViewProtocol) {
        self.view = view
    }
    
    func configurateView() {
        service = StocksService()
        downloadStockIndices()
    }
    
    func downloadStockIndices() {
        service.loadStocksList(with: "^GSPC", completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.model = StocksListModel()
                self?.model?.indices = result.constituents.sorted()
                self?.view.sendModelToCollection(self?.model)
            case .failure(let error):
                print(error)
            }
        })
    }
}

