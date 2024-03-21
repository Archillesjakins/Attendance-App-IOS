//
//  User.swift
//  Attendance App
//
//  Created by jake on 27/03/2024.
//

import Foundation

struct User {
    let name: String
    let email: String
    let password: String
    // Add any other properties you need for your user model
    
    // You can also add an initializer if needed
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}

class DatabaseManager {
    // This method simulates saving the user data to a database
    func saveUserToDatabase(_ user: User) {
        // Here you would implement the logic to save the user data to your database
        // For demonstration purposes, let's just print the user data
        print("Saving user to database:")
        print("Name: \(user.name)")
        print("Email: \(user.email)")
        // Do not print the password for security reasons
    }
}
