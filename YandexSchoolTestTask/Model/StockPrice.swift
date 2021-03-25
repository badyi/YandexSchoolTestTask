//
//  StockPrice.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 15.03.2021.
//

import Foundation

final class StockPrice: Codable {
    let c: Double
    let h: Double
    let l: Double
    let o: Double
    let pc: Double
    let t: Double

    init(c: Double, h: Double, l: Double, o: Double, pc: Double, t: Double) {
        self.c = c
        self.h = h
        self.l = l
        self.o = o
        self.pc = pc
        self.t = t
    }
}
