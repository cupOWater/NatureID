//
//  Post.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import Foundation

struct Post : Codable{
    var id : String
    var userId : String
    var imageUrl : String
    var description : String
    var category : String // Plant, Animal, Fungus, Others
    var createdAt : Date
    var comments : [Comment]
}
