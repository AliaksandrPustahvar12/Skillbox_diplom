//
//  DoubleExtension.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 22.01.23.
//

import UIKit

extension Double {
    
    var asMoney: String {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.currencySymbol = "руб."
        return formatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
