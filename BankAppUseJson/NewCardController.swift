//
//  NewCardController.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 22.04.24.
//

import UIKit

class NewCardController: UIViewController {

    @IBOutlet weak private var cvcField: UITextField!
    @IBOutlet weak private var expireDateField: UITextField!
    @IBOutlet weak private var cardNumberField: UITextField!
    @IBOutlet weak private var cardNameField: UITextField!
    @IBOutlet weak private var balanceField: UITextField!
    @IBOutlet weak private var errorLabel: UILabel!
    
    var cardCallback: ((Card) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yeni kart"
        errorLabel.isHidden = true
    }

    @IBAction func createCardTappedButton(_ sender: Any) {
        if cardNameField.text == "" ||
            cardNumberField.text == "" ||
            expireDateField.text == "" ||
            cvcField.text == "" ||
            balanceField.text == "" {
            errorLabel.text = "Zəhmət olmasa bütün boş xanaları doldurun."
            errorLabel.isHidden = false
        } else {
            let newCard = Card(name: cardNameField.text ?? "",
                               number: cardNumberField.text ?? "",
                               exdate: expireDateField.text ?? "",
                               cvc: cvcField.text ?? "",
                               balance: balanceField.text ?? "")
            cardCallback?(newCard)
            navigationController?.popViewController(animated: true)
        }
    }
}
