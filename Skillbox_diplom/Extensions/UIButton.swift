//
//  Button.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 4.02.23.
//

import UIKit

extension UIButton {
    
    func setUp() {
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.darkGreen?.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        self.layer.shadowColor = UIColor.systemGreen.cgColor
    }
}
