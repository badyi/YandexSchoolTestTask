//
//  StocksCollectionView.swift
//  YandexSchoolTest
//
//  Created by Бадый Шагаалан on 21.02.2021.
//

import UIKit

final class StocksCollectionView: UIViewController {
    
    var configurator: StocksConfiguratorProtocol! = StocksConfigurator()
    var presenter: StocksPresenterProtocol!
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        
        cv.contentInset = UIEdgeInsets(top: Sizes.StockListButtonsSize + 1, left: 16, bottom: 0, right: 16)
        cv.isScrollEnabled = true
        cv.alwaysBounceVertical = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .blue
        cv.scrollIndicatorInsets = UIEdgeInsets(top: Sizes.StockListButtonsSize + 1, left: 0, bottom: 0, right: 0)
        cv.register(StockListCell.self, forCellWithReuseIdentifier: StockListCell.id)
        
        return cv
    }()
    
    init(with type: CollectionType) {
        super.init(nibName: nil, bundle: nil)
        configurator.configurate(with: self, cvType: type)
        presenter.configurateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func set(_ model: StocksListModel?) {
        presenter.set(model)
    }
}

extension StocksCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.willDisplay(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.didEndDisplay(at: indexPath)
    }
}

extension StocksCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockListCell.id, for: indexPath) as! StockListCell
        if let proifle = presenter.profile(at: indexPath) {
            cell.configData(with: proifle, at: indexPath)
            cell.delegate = self
            cell.isFavorite = presenter.isFavorite(at: indexPath)
        }
        cell.backgroundColor = ColorManager.currentStyle().mainColor
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .lightGray
        }
        return cell
    }
}

extension StocksCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        let height: CGFloat = 68
        return CGSize(width: width, height: height)
    }
}

extension StocksCollectionView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0 {
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }, completion: nil)
        }
    }
}

extension StocksCollectionView: StocksViewProtocol {
    func changeView(with index: Int) {
        
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func reloadItems(at index: [IndexPath]) {
        collectionView.reloadItems(at: index)
    }
    
    func configCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension StocksCollectionView: StocksCellDelegate {
    func configFavorite(for symbol: String, at index: IndexPath) {
        presenter.configFavorite(for: symbol, at: index)
    }
}
