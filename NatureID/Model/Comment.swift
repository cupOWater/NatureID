//
//  Comment.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import Foundation

struct Comment : Codable {
    var id = UUID()
    var content : String? = "User comment blablabaeufhuehfleuhrnicluehlukeukhk oiruhgkuehnrughietu ouerlkuthynviuwhaeunntieiufynr"
    var createdAt : Date? 
    var vote : Int = 0
    var user : User = User(userName:"User Name")
    var postId : String?
}
