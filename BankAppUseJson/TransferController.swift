//
//  TransferController.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 22.04.24.
//

import UIKit

class TransferController: UIViewController {

    @IBOutlet weak private var amountField: UITextField!
    @IBOutlet weak private var reciverCardField: UITextField!
    @IBOutlet weak private var errorLabel: UILabel!
    
    var card: Card?
    var endBalance = 0
    
    var balanceUpdateCallback: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transfer"
        errorLabel.isHidden = true
    }

    @IBAction func transferTappedButton(_ sender: Any) {
        if amountField.text == "" ||
            reciverCardField.text == "" {
            errorLabel.text = "Zəhmət olmasa bütün boş xanaları doldurun."
            errorLabel.isHidden = false
        } else {
            var balance = Int(card!.balance) ?? 0
            let transferAmount = Int(amountField.text ?? "") ?? 0
            
            if (balance < transferAmount) {
                errorLabel.text = "Balansınızda kifayət qədər məbləğ yoxdur!"
                errorLabel.isHidden = false
            } else {
                if (balance >= transferAmount) {
                    balance -= transferAmount
                    balanceUpdateCallback?(balance)
                }
                    
                let alertController = UIAlertController(title: "Uğurlu əməliyyat!",
                                                        message: "Balansınız: \(balance)",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                errorLabel.isHidden = true
            }
        }
    }
}
