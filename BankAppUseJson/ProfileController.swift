//
//  ProfileController.swift
//  BankAppWithClosure
//
//  Created by Zahra Alizada on 24.04.24.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var user: RegisterUser?
    var manager = FileManagerHelper()
    var userCards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profil"
        
        let powerIcon = UIImage(systemName: "power")?.withRenderingMode(.alwaysOriginal).withTintColor(.red)
        let logoutBtn = UIBarButtonItem(image: powerIcon, style: .plain, target: self, action: #selector(logoutTappedButton(_:)))
        navigationItem.rightBarButtonItem = logoutBtn
    }
    
    @IBAction func logoutTappedButton(_ sender: Any) {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate: SceneDelegate = scene?.delegate as? SceneDelegate {
            sceneDelegate.setLoginAsRoot()
        }
    }
}
extension ProfileController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileInfoCell.self)", for: indexPath) as! ProfileInfoCell
            
            if let savedEmail = UserDefaults.standard.string(forKey: "email") {
                manager.getUsers { users in
                    let userIndex = users.firstIndex(where: {$0.email == savedEmail})
                    cell.config(fullname: users[userIndex!].fullname,
                                email: users[userIndex!].email,
                                phone: users[userIndex!].phone,
                                password: users[userIndex!].password)
                }
            } else {
                print("-- Email not found --")
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileCardCell.self)", for: indexPath) as! ProfileCardCell
            if let savedEmail = UserDefaults.standard.string(forKey: "email") {
                manager.getUsers { users in
                    let userIndex = users.firstIndex(where: {$0.email == savedEmail})
                    userCards = users[userIndex!].cards
                }
                if userCards.count > 0 {
                    return cell
                } else {
                    cell.isHidden = true
                    return cell
                }
            }
            return cell
        default:
            fatalError("Unexpected indexPath.row")
        }
    }
}

extension ProfileController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        } else if indexPath.row == 1 {
            return 230
        } else {
            return 300
        }
    }
}

extension ProfileController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardCollectionCell.self)", for: indexPath) as! CardCollectionCell
        let card = userCards[indexPath.row]
        cell.config(name: card.name,
                    number: card.number,
                    date: card.exdate,
                    cvc: card.cvc,
                    balance: card.balance)
        return cell
    }
}

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 170)
    }
}
