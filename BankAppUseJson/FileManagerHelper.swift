//
//  FileManagerHelper.swift
//  BankAppWithClosure
//
//  Created by Zahra Alizada on 04.05.24.
//

import Foundation

class FileManagerHelper {
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent("Users.json")
        return path
    }
    
    func saveUser(data: [RegisterUser]) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: getFilePath())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getUsers(complete: (([RegisterUser]) -> Void)) {
        if let data = try? Data(contentsOf: getFilePath()) {
            do {
                let user = try JSONDecoder().decode([RegisterUser].self, from: data)
                complete(user)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
}
