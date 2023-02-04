//
//  UISegmentedControl.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 4.02.23.
//

import UIKit

extension UISegmentedControl {
    
    func setUp() {
        self.selectedSegmentIndex = 3
        self.layer.cornerRadius = 12
        self.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Thonburi", size: 15)!], for: .selected)
        self.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
}
