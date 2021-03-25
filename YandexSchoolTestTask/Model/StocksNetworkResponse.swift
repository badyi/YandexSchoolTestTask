//
//  StocksModel.swift
//  YandexSchoolTest
//
//  Created by Бадый Шагаалан on 07.03.2021.
//

import Foundation

struct IndicesResponse: Codable {
    let constituents: [String]
    let symbol: String
}

struct StocksProfileResponseff: Codable {
    let country, currency, exchange, finnhubIndustry: String
    let ipo: String
    let logo: String
    let marketCapitalization: Double
    let name, phone: String
    let shareOutstanding: Double
    let ticker: String
    let weburl: String
}
	
