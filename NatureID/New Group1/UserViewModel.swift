//
//  UserViewModel.swift
//  NatureID
//
//  Created by MacNCheese on 13/09/2023.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class UserViewModel : ObservableObject{
    @Published var user : User = User()
    let imageManager = ImageManager()
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    func register(password : String, image : UIImage, completion: @escaping (String?) -> Void) {
        
        auth.createUser(withEmail: user.email, password: password){ authResult, error in
            if error != nil{
                completion(error!.localizedDescription)
                return
            }
            // let currentUser = authResult?.user
            
            // Upload image
//            self.imageManager.upload(image: image, name: currentUser!.uid) { url in
//                if(url == nil){
//                    return
//                }
//            }
            completion(nil)
        }
    }
    
    func login(password : String) {
        
    }
    
}
