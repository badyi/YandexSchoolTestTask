//
//  StocksListPageVIewController.swift
//  YandexSchoolTest
//
//  Created by Бадый Шагаалан on 21.02.2021.
//

import UIKit

enum CollectionType {
    case deafult
    case favortie
}

final class MainPageViewController: UIPageViewController { 
    
    var configurator: MainPageViewConfiguratorProtocol = MainPageViewConfigurator()
    var presenter: MainPageViewPresenterProtocol!
    
    var subViewControllers: [UIViewController] = [StocksCollectionView(with: .deafult), StocksCollectionView(with: .favortie)]
     
    weak var viewDelegate: MainViewDelegate?  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configurate(with: self)
        presenter.configurateView()
        dataSource = self
        delegate = self
        self.setViewControllers([subViewControllers[0]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        //var ws = WSManager()
        //ws.connectToWebSocket()
        //ws.subscribe("AAPL")
        //ws.subscribe("TSLA")
    }
    
    func setViewController(with index: Int) {
        var direction = UIPageViewController.NavigationDirection.forward
        if index == 0 {
            direction = UIPageViewController.NavigationDirection.reverse
        }
        self.setViewControllers([subViewControllers[index]], direction: direction, animated: true, completion: nil)
    }
}

extension MainPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let currentIndex: Int = subViewControllers.firstIndex(of: pendingViewControllers.first!) ?? 0
        viewDelegate?.viewChanged(currentIndex)
    }
}


extension MainPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        
        if currentIndex <= 0 {
            return nil
        }
        viewDelegate?.viewChanged(currentIndex)
        return subViewControllers[currentIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex >= subViewControllers.count - 1{
            return nil
        }
        viewDelegate?.viewChanged(currentIndex)
        return subViewControllers[currentIndex + 1]
    }
}

extension MainPageViewController: MainPageViewProtocol {
    func sendModelToCollection(_ model: StocksListModel?) {
        (subViewControllers[0] as! StocksCollectionView).set(model)
        (subViewControllers[1] as! StocksCollectionView).set(model)
    }
    
    func changeView(with index: Int) {
        setViewController(with: index)
    }
}
    
    
