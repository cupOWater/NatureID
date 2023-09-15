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
    @Published var user : User = User()
    let db = Firestore.firestore()
    
    init( id : String = ""){
        if(id == "") {
            return
        }
        getUser(id: id) { user in
            if let user = user {
                self.user = user
            }
        }
    }
    
    func getUser(id : String, completion: @escaping (User?) -> Void) {
        let docRef = db.collection("user").document(id)
        docRef.getDocument { document, error in
            if error != nil {
                print(error!.localizedDescription)
                completion(nil)
                return
            }
            
            if let document = document {
                do {
                    let user = try document.data(as: User.self)
                    completion(user)
                }
                catch {
                    print(error)
                    completion(nil)
                    return
                }
            }
        }
    }
}
