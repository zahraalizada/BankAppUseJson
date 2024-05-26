//
//  RegisterUser.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 22.04.24.
//

import Foundation

struct RegisterUser: Codable {
    let fullname: String
    let email: String
    let phone: String
    let password: String
    var cards: [Card]
}
