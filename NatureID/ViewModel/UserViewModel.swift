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
    @Published var isLoggedIn : Bool
    
    let imageManager = ImageManager()
    let db = Firestore.firestore()
    let auth = Auth.auth()
    
    init() {
        let currentUser = auth.currentUser
        
        if(currentUser == nil){
            self.isLoggedIn = false
        }else {
            self.isLoggedIn = true
            self.user.id = currentUser!.uid
            self.user.email = currentUser!.email!
        }
    }
    
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
    
    func login(password : String, completion: @escaping (String?) -> Void) {
        
        auth.signIn(withEmail: user.email, password: password) { authResult, error in
            if(error != nil){
                completion(error!.localizedDescription)
                return
            }
            
            // Replace with Firestore data when implemented
            self.user.id = authResult?.user.uid ?? ""
            
            withAnimation {
                self.isLoggedIn = true
            }
            completion(nil)
        }
    }
    
    func logout() {
        do {
            try auth.signOut()
            user = User()
            withAnimation {
                self.isLoggedIn = false
            }
        } catch {
            print(error)
        }
    }
    
}
