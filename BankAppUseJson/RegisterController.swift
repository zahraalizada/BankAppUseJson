//
//  RegisterController.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 20.04.24.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet weak private var regFullnameTextField: UITextField!
    @IBOutlet weak private var regEmailTextField: UITextField!
    @IBOutlet weak private var regPhoneTextField: UITextField!
    @IBOutlet weak private var regPasswordTextField: UITextField!
    @IBOutlet weak var regErrorLabel: UILabel!
    
    var callback: ((RegisterUser) -> Void)?
    
    let manager = FileManagerHelper()
    var users = [RegisterUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Qeydiyyat"
        regErrorLabel.isHidden = true
      
        manager.getUsers { userItems in
            self.users = userItems
        }
    }

    @IBAction func registerTappedButton(_ sender: Any) {
        
        if regFullnameTextField.text == "" ||
           regEmailTextField.text == "" ||
           regPhoneTextField.text == "" ||
           regPasswordTextField.text == "" {
            regErrorLabel.text = "Zəhmət olmasa bütün boş xanaları doldurun."
            regErrorLabel.isHidden = false
        } else {
            if manager.isValidEmail(email: regEmailTextField.text ?? ""){
                UserDefaults.standard.setValue(true, forKey: "userRegistered")
                
                let user = RegisterUser(fullname: regFullnameTextField.text ?? "",
                                        email: regEmailTextField.text ?? "",
                                        phone: regPhoneTextField.text ?? "",
                                        password: regPasswordTextField.text ?? "",
                                        cards: [Card(name: "Salary",
                                                     number: "1234 5678 9012 3456",
                                                     exdate: "2024",
                                                     cvc: "123",
                                                     balance: "2000")
                                                ])
                callback?(user)
                users.append(user)
                manager.saveUser(data: users)
        
                navigationController?.popViewController(animated: true)
            } else {
                regErrorLabel.text = "Zəhmət olmasa düzgün email daxil edin."
                regErrorLabel.isHidden = false
            }
            
           
        }
    }
}
