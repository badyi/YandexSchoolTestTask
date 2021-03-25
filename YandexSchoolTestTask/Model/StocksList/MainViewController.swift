//
//  StocksListViewController.swift
//  YandexSchoolTest
//
//  Created by Бадый Шагаалан on 15.02.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    var configurator: MainViewConfiguratorProtocol = MainViewConfigurator()
    var presenter: MainViewPresenterProtocol!
    
    var page: MainPageViewController!

    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.backgroundColor = ColorManager.currentStyle().mainColor
        let text = NSAttributedString(string: "Find company or ticker", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        let textField = search.value(forKey: "searchField") as? UITextField
        textField?.leftView?.tintColor = ColorManager.currentStyle().textTintColor
        textField?.attributedPlaceholder = text
        textField?.backgroundColor = ColorManager.currentStyle().mainColor
        textField?.textColor = ColorManager.currentStyle().textColor
        textField?.tintColor = ColorManager.currentStyle().textTintColor
        textField?.layer.cornerRadius = 19
        textField?.clipsToBounds = true
        textField?.layer.borderColor = ColorManager.currentStyle().textTintColor.cgColor
        textField?.layer.borderWidth = 1
        textField?.clearButtonMode = .whileEditing
        
        return search
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Stocks", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.setTitleColor(ColorManager.currentStyle().textColor, for: .normal)
        button.contentVerticalAlignment = .bottom
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(buttonLeftClicked), for: .touchUpInside)
        button.backgroundColor = ColorManager.currentStyle().mainColor
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Favourite", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.gray, for: .normal)
        #warning("color")
        button.contentVerticalAlignment = .bottom
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        button.addTarget(self, action: #selector(buttonRightClicked), for: .touchUpInside)
        button.backgroundColor = ColorManager.currentStyle().mainColor
        return button
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.currentStyle().mainColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        page = MainPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        page.view.translatesAutoresizingMaskIntoConstraints = false
        
        configurator.configurate(with: self)
        presenter.configurateView()
    }
    
    @objc func buttonLeftClicked(sender: UIButton?)
    {
        leftButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        rightButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        #warning("color")
        leftButton.setTitleColor(.black, for: .normal)
        rightButton.setTitleColor(.gray, for: .normal)

        changeView(viewIndex: 0)
    }
    
    @objc func buttonRightClicked(sender: UIButton?)
    {
        rightButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        leftButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        rightButton.setTitleColor(.black, for: .normal)
        leftButton.setTitleColor(.gray, for: .normal)
        changeView(viewIndex: 1)
    }
    
    func changeView(viewIndex: Int) {
        switch viewIndex {
        case 0:
            page.changeView(with: viewIndex)
        case 1:
            page.changeView(with: viewIndex)
        default:
            page.changeView(with: 0)
        }
    }
}

extension MainViewController: MainViewProtocol {
    func configView() {
        view.backgroundColor = ColorManager.currentStyle().mainColor
        self.addChild(page)
        page.viewDelegate = self
        view.addSubview(page.view)
        view.addSubview(backView)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
    }
    
    func configBackView() {
        backView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: leftButton.bottomAnchor).isActive = true
    }
    
    func configButtons() {
        leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leftButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: Sizes.StockListButtonsSize).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: view.frame.width / 3).isActive = true
        leftButton.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor).isActive = true
        
        rightButton.topAnchor.constraint(equalTo: leftButton.topAnchor).isActive = true
        rightButton.heightAnchor.constraint(equalTo: leftButton.heightAnchor).isActive = true
        rightButton.bottomAnchor.constraint(equalTo: leftButton.bottomAnchor).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func configPageVC() {
        let top = (navigationController?.navigationBar.frame.height ?? 0) + UIApplication.shared.statusBarFrame.height
        page.view.topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        page.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        page.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        page.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configSearchBar() {
        navigationItem.titleView = searchBar
    }
}

extension MainViewController: MainViewDelegate {
    func viewChanged(_ index: Int) {
        if index == 0 {
            leftButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
            rightButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            #warning("color")
            leftButton.setTitleColor(.black, for: .normal)
            rightButton.setTitleColor(.gray, for: .normal)
        } else if index == 1 {
            rightButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
            leftButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            
            rightButton.setTitleColor(.black, for: .normal)
            leftButton.setTitleColor(.gray, for: .normal)
        }
    }
}
