//
//  UserModel.swift
//  iTunesTestTask
//
//  Created by Никита Козловский on 17.10.2024.
//

import Foundation

struct User: Codable {
    let firstName: String
    let secondName: String
    let phone: String
    let email: String
    let password: String
    let age: Date
}
