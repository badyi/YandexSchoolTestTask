//
//  StocksListCell.swift
//  YandexSchoolTest
//
//  Created by Бадый Шагаалан on 21.02.2021.
//

import UIKit

final class StockListCell: UICollectionViewCell {
    
    static let id = "StockListCell"
    
    weak var delegate: StocksCellDelegate?
    var index: IndexPath?
    var isFavorite: Bool = false
    
    private lazy var companyIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var favoriteIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "favIcon")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favIconTapped))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
        image.tintColor = ColorManager.currentStyle().tintNotFavIconColor
        return image
    }()
    
    private lazy var tickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Ticker"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = ColorManager.currentStyle().textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = ColorManager.currentStyle().textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Company name"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.textColor = ColorManager.currentStyle().textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Price"
        return label
    }()
    
    private lazy var dayDeltaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .right
        label.textColor = ColorManager.currentStyle().textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Day delta"
        label.backgroundColor = .brown
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        companyIcon.image = nil
        favoriteIcon.image = nil
        priceLabel.text = "Price"
        dayDeltaLabel.text = "Day delta"
        companyNameLabel.text = "Company name"
        tickerLabel.text = "Ticker"
    }
    
    func configData(with profile: StockProfile, at index: IndexPath) {
        self.index = index
        favoriteIcon.image = UIImage(named: "favIcon")
        companyNameLabel.text = profile.name
        tickerLabel.text = profile.ticker
        
        if let logoData = profile.imageData {
            companyIcon.image = UIImage(data: logoData)
        }
    }
    
    func configView() {
        layer.cornerRadius = 16
        
        contentView.addSubview(companyIcon)
        contentView.addSubview(tickerLabel)
        contentView.addSubview(companyNameLabel)
        contentView.addSubview(favoriteIcon)
        contentView.addSubview(tickerLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(dayDeltaLabel)
        
        configCompanyIcon()
        configTickerLabel()
        configCompanyNameLabel()
        configFavIcon()
        configPriceLabel()
        configDayDeltaLabel()
    }
    
    @objc func favIconTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if index != nil {
            delegate?.configFavorite(for: tickerLabel.text ?? "", at: index!)
        }
    }
    
    func configCompanyIcon() {
        companyIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        companyIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        companyIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        companyIcon.widthAnchor.constraint(equalToConstant: 52).isActive = true
        companyIcon.heightAnchor.constraint(equalToConstant: 52).isActive = true
        companyIcon.trailingAnchor.constraint(equalTo: tickerLabel.leadingAnchor, constant: -12).isActive = true
    }
    
    func configTickerLabel() {
        tickerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
        tickerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        tickerLabel.trailingAnchor.constraint(equalTo: favoriteIcon.leadingAnchor, constant: -5).isActive = true
    }
    
    func configCompanyNameLabel() {
        companyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 72).isActive = true
        companyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 38).isActive = true
        companyNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14).isActive = true
    }
    
    func configFavIcon() {
        favoriteIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17).isActive = true
        favoriteIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -34).isActive = true
        favoriteIcon.widthAnchor.constraint(equalToConstant: 17).isActive = true
        favoriteIcon.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    func configPriceLabel() {
        priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: dayDeltaLabel.topAnchor).isActive = true
    }
    
    func configDayDeltaLabel() {
        dayDeltaLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        dayDeltaLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14).isActive = true
    }
}


