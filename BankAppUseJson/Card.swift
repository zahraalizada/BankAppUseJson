//
//  Card.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 22.04.24.
//

import Foundation

struct Card: Codable {
    let name: String
    let number: String
    let exdate: String
    let cvc: String
    var balance: String
}
