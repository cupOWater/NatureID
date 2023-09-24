/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Huynh Ky Thanh
  ID: 3884734
  Created date: 12/09/2023
  Last modified: 24/09/2023
  Acknowledgement:
*/

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
