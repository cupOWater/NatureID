//
//  Comment.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import Foundation

struct Comment : Codable {
    var id : String
    var content : String
    var createdAt : Date
    var vote : Int
}
