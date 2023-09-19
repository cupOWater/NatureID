//
//  NatureIDApp.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//
//  https://designcode.io/swiftui-handbook-conditional-modifier
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
    
    @StateObject var session = SessionManager()
    @State var splashScreen : Bool = true
    @Environment(\.colorScheme) var colorScheme
    var body: some Scene {
        WindowGroup {
            if(splashScreen) {
                SplashScreenView(splashScreen: $splashScreen)
            }else {
                if session.user.id == nil{
                    LoginView()
                        .environmentObject(session)
                }else {
                    ContentView()
                        .environmentObject(session)
                        .preferredColorScheme({
                            if(session.user.themeSetting == "Auto"){
                                return nil
                            }else if(session.user.themeSetting == "Light"){
                                return .light
                            }else {
                                return .dark
                            }
                        }())
                }
            }
        }
    }
}

