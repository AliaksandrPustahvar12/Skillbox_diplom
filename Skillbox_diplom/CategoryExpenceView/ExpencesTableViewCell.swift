//
//  ExpencesTableViewCell.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 20.01.23.
//

import UIKit

class ExpencesTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
