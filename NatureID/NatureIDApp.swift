//
//  NatureIDApp.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import SwiftUI
import FirebaseCore

@main
struct NatureIDApp: App {
    @State var splashScreen : Bool = true
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if(splashScreen) {
                SplashScreenView(splashScreen: $splashScreen)
            }else{
                ContentView()
            }
            
        }
    }
}
