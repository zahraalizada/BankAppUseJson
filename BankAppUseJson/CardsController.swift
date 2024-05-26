//
//  CardsController.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 20.04.24.
//

import UIKit

class CardsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var manager = FileManagerHelper()
    var userCards = [Card]()
    var usersArr = [RegisterUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kartlar"
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCardTappedButton(_:)))
        navigationItem.rightBarButtonItem = addBtn
        tableView.register(UINib(nibName: "\(ItemCell.self)", bundle: nil), forCellReuseIdentifier: "\(ItemCell.self)")
        getCurrentUserCards()
    }
    
    func getCurrentUserCards() {
        if let savedEmail = UserDefaults.standard.string(forKey: "email") {
            manager.getUsers { users in
                let userIndex = users.firstIndex(where: {$0.email == savedEmail})
                userCards = users[userIndex!].cards
                usersArr.append(users[userIndex!])
                manager.saveUser(data: usersArr)
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func addCardTappedButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "\(NewCardController.self)") as! NewCardController
        controller.cardCallback = { newCard in
            self.userCards.append(newCard)
            if let userIndex = self.usersArr.firstIndex(where: {$0.email == UserDefaults.standard.string(forKey: "email")}) {
                self.usersArr[userIndex].cards.append(newCard)
                self.manager.saveUser(data: self.usersArr)
            }
            self.tableView.reloadData()
        }
        navigationController?.show(controller, sender: nil)
    }
}

extension CardsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ItemCell.self)") as! ItemCell
        let card = userCards[indexPath.row]
        cell.itemLabel.text = card.name
        return cell
    }
}

extension CardsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = userCards[indexPath.row]
        let controller = storyboard?.instantiateViewController(identifier: "\(TransferController.self)") as! TransferController
        controller.card = card
        controller.balanceUpdateCallback = { newBalance in
            self.userCards[indexPath.row].balance = String(newBalance)
            if let userIndex = self.usersArr.firstIndex(where: {$0.email == UserDefaults.standard.string(forKey: "email")}),
               let cardIndex = self.usersArr[userIndex].cards.firstIndex(where: {$0.name == self.userCards[indexPath.row].name}) {
                self.usersArr[userIndex].cards[cardIndex].balance = String(newBalance)
            }
            self.manager.saveUser(data: self.usersArr)
            self.tableView.reloadData()
        }
        navigationController?.show(controller, sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
