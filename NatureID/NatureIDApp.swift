//
//  NatureIDApp.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct NatureIDApp: App {
    @StateObject var userVm = UserViewModel()
    @State var splashScreen : Bool = true
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if(splashScreen) {
                SplashScreenView(splashScreen: $splashScreen)
            }else{
                if(Auth.auth().currentUser == nil) {
                    LoginView(userVm: userVm)
                }else {
                    ContentView()
                }
            }
            
        }
    }
}
