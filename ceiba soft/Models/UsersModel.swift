//
//  UsersStruct.swift
//  ceiba soft
//
//  Created by Crhistian Vergara Gomez on 2/07/20.
//  Copyright © 2020 Crhistian Vergara Gomez. All rights reserved.
//

import Foundation

class UserModel: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
}
