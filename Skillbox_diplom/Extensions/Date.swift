//
//  Date.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 4.02.23.
//

import UIKit

extension Date {
    
    var startDay: Self {
        Calendar.current.date(bySettingHour: .zero, minute: .zero, second: .zero, of: self)!
    }
    var week: Self {
        Calendar.current.date(byAdding: .day, value: -7, to: self)!
    }
    var month: Self {
        Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
    var quarter: Self {
        Calendar.current.date(byAdding: .month, value: -3, to: self)!
    }
    var allPeriod: Self {
        Calendar.current.date(byAdding: .year, value: -5, to: self)!
    }
}
