//
//  UserViewModel.swift
//  NatureID
//
//  Created by MacNCheese on 14/09/2023.
//

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
    
}
