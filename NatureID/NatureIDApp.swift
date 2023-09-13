//
//  NatureIDApp.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate : NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct NatureIDApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var userVm = UserViewModel()
    @State var splashScreen : Bool = true
    
    
    var body: some Scene {
        WindowGroup {
            if(splashScreen) {
                SplashScreenView(splashScreen: $splashScreen)
            }else{
                if(!userVm.isLoggedIn) {
                    LoginView(userVm: userVm)
                }else {
                    ContentView()
                        .environmentObject(userVm)
                }
            }
            
        }
    }
}
