//
//  User.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import Foundation


struct User : Codable {
    var id : String
    var bio : String
    var email : String
    var password : String
    var userName : String
    var imageUrl : String
    var themeSetting : String // Auto, Light, Dark
}
