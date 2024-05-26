//
//  CardCollectionCell.swift
//  BankAppWithClosure
//
//  Created by Zahra Alizada on 24.04.24.
//

import UIKit

class CardCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var numberlabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var cvcLabel: UILabel!
    @IBOutlet weak private var balanceLabel: UILabel!
    
    func config (name: String, number: String, date: String, cvc: String, balance: String) {
        nameLabel.text = name
        numberlabel.text = number
        dateLabel.text = date
        cvcLabel.text = cvc
        balanceLabel.text = balance
    }
}
