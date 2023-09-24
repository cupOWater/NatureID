/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Huynh Ky Thanh
  ID: 3884734
  Created date: 14/09/2023
  Last modified: 24/09/2023
  Acknowledgement:
*/

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserViewModel : ObservableObject {
    @Published var users = [User]()
    private let db = Firestore.firestore()
    
    init(){
        getUsers()
    }
    
    func getUsers(){
        db.collection("user").addSnapshotListener { querySnapshot, error in
            if(error != nil) {
                print(error!.localizedDescription)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No user")
                return
            }
            
            do {
                self.users = try documents.map({ (queryDocumentSnapshot) -> User in
                    let user = try queryDocumentSnapshot.data(as: User.self)
                    return user
                })
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getUserById(id: String) -> User{
        let users = self.users.filter({$0.id == id})
        if(users.isEmpty){
            return User()
        }else {
            return users[0]
        }
    }
    
}
