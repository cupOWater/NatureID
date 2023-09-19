//
//  Post.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import Foundation
import FirebaseFirestore

struct Post : Codable, Identifiable{
    var id : String = UUID().uuidString
    var userId : String = ""
    var imageUrl : String = ""
    var description : String = ""
    var category : String = "Others" // Plant, Animal, Fungus, Others
    var createdAt : Date = Date.now
    var comments : [Comment] = []
    var isIdentified : Bool = false
}
