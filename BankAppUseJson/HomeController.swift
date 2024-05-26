//
//  HomeController.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 20.04.24.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    var menu = [Menu]()
    let menuManager = MenuManager()
    
    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Xoş Gəlmisiniz!"
        menu = menuManager.getMenuItems()
        tableView.register(UINib(nibName: "\(ItemCell.self)", bundle: nil), forCellReuseIdentifier: "\(ItemCell.self)")
    }
}

extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ItemCell.self)") as! ItemCell
        cell.itemLabel.text = menu[indexPath.row].title
        return cell
    }
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = menu[indexPath.row].title
        
        switch title {
        case "Kartlar":
            let controller = storyboard?.instantiateViewController(identifier: "\(CardsController.self)") as! CardsController
            navigationController?.show(controller, sender: nil)
        case "Profil":
            let controller = storyboard?.instantiateViewController(identifier: "\(ProfileController.self)") as! ProfileController
            navigationController?.show(controller, sender: nil)
        default:
            print("Unknown menu option")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
