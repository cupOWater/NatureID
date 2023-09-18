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
    var createdAt : Date = Date.now
    var vote : Int = 0
    var userId : String?
    var postId : String?
}
