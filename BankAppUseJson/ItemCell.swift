//
//  ItemCell.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 22.04.24.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func itemTappedButton(_ sender: Any) {
    }
}
