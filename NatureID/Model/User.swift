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

struct User : Codable {
    var id : String?
    var email : String = ""
    var userName : String = ""
    var photoUrl : String = ""
    var bio : String = ""
    var themeSetting : String = "Auto" // Auto, Light, Dark
}
