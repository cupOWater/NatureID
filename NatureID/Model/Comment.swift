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

struct Comment : Codable,Identifiable {
    var id = UUID().uuidString
    var content : String? = "User comment blablabaeufhuehfleuhrnicluehlukeukhk oiruhgkuehnrughietu ouerlkuthynviuwhaeunntieiufynr"
    var createdAt : Date = Date.now
    var userId : String?
    var postId : String?
    var upVotedUserIds : Set<String> = []
    var downVotedUserIds : Set<String> = []
}
