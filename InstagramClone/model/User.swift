//
//  User.swift
//  instagramClone
//
//  Created by agmma on 5/1/24.
//

import Foundation

struct User: Codable {
    let id: String
    let email: String
    var userName: String
    var name: String
    var bio: String?
    var profileImageUrl: String?
}
