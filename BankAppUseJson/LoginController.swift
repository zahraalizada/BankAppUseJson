//
//  LoginController.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 20.04.24.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak private var loginEmailField: UITextField!
    @IBOutlet weak private var loginPasswordField: UITextField!
    @IBOutlet weak private var errorLabel: UILabel!
    
    var loginUser: LoginUser?
    var user: RegisterUser?
    let manager = FileManagerHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Giriş"
        errorLabel.isHidden = true
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let email = loginEmailField.text ?? ""
        let password = loginPasswordField.text ?? ""
        
        manager.getUsers { users in
            if manager.isValidEmail(email: email) {
                if users.contains(where: {$0.email == email && $0.password == password}) {
                    UserDefaults.standard.setValue(email, forKey: "email")
                    let controller  = self.storyboard?.instantiateViewController(identifier: "\(HomeController.self)") as! HomeController
                    self.navigationController?.show(controller, sender: nil)
                }  else if loginEmailField.text == "" || loginPasswordField.text == "" {
                    errorLabel.text = "Email və ya şifrə xanası boş buraxıla bilməz."
                    errorLabel.isHidden = false
                } else {
                    errorLabel.text = "Daxil etdiyiniz e-mail və ya şifrə yanlışdır."
                    errorLabel.isHidden = false
                }
            } else {
                errorLabel.text = "Daxil etdiyiniz e-mail formatı yanlışdır."
                errorLabel.isHidden = false
            }
        }
    }
    
    @IBAction func registerTappedButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "\(RegisterController.self)") as! RegisterController
            controller.callback = { user in
            self.loginUser = LoginUser(name: user.email,
                                       password: user.password)
            self.loginEmailField.text = user.email
            self.loginPasswordField.text = user.password
        }
        navigationController?.show(controller, sender: nil)
        errorLabel.isHidden = true
    }
}
