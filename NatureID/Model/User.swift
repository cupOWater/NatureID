//
//  User.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import Foundation

struct User : Codable {
    var id : String = ""
    var email : String = ""
    var userName : String = ""
    var photoUrl : String = ""
    var bio : String = ""
    var themeSetting : String = "Auto" // Auto, Light, Dark
}
