//
//  ProfileInfoCell.swift
//  BankAppWithClosure
//
//  Created by Zahra Alizada on 25.04.24.
//

import UIKit

class ProfileInfoCell: UITableViewCell {
    
    @IBOutlet weak private var fullnameLabel: UILabel!
    @IBOutlet weak private var emailLabel: UILabel!
    @IBOutlet weak private var phoneLabel: UILabel!
    @IBOutlet weak private var passwordlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config (fullname: String, email: String, phone: String, password: String) {
        fullnameLabel.text = fullname
        emailLabel.text = email
        phoneLabel.text = phone
        passwordlabel.text = password
    }
}
