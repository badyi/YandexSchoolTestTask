//
//  StockProfileModel.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 12.03.2021.
//

import Foundation

final class StockProfile: Codable {
    let country, currency, exchange, finnhubIndustry: String
    let ipo: String
    let logo: String
    let marketCapitalization: Double
    let name, phone: String
    let shareOutstanding: Double
    let ticker: String
    let weburl: String
    var price: StockPrice?
    var imageData: Data?
    
    init(country: String, currency: String, exchange: String, finnhubIndustry: String, ipo: String, logo: String, marketCapitalization: Double, name: String, phone: String, shareOutstanding: Double, ticker: String, weburl: String) {
        self.country = country
        self.currency = currency
        self.exchange = exchange
        self.finnhubIndustry = finnhubIndustry
        self.ipo = ipo
        self.logo = logo
        self.marketCapitalization = marketCapitalization
        self.name = name
        self.phone = phone
        self.shareOutstanding = shareOutstanding
        self.ticker = ticker
        self.weburl = weburl
    }
}
