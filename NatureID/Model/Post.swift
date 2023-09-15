//
//  Post.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import Foundation
import FirebaseFirestore

struct Post : Codable{
    var id : UUID?
    var user : DocumentReference
    var imageUrl : String = ""
    var description : String = ""
    var category : String = "Others" // Plant, Animal, Fungus, Others
    var createdAt : Date = Date.now
    
    init(userId : String){
        self.user = Firestore.firestore().document(userId)
    }
}
