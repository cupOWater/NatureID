//
//  SettingView.swift
//  NatureID
//
//  Created by MacNCheese on 17/09/2023.
//

import SwiftUI

struct SettingView: View {
    @Binding var viewSelection : String
    @EnvironmentObject var session : SessionManager
    @AppStorage("faceIdEnabled") var faceIdEnabled = false
    @AppStorage("faceIdEmail") var faceIdEmail = ""
    @AppStorage("faceIdPwd") var faceIdPwd = ""
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                List {
                    Section(content: {
                        Button("Disable FaceID") {
                            faceIdEnabled = false
                            faceIdPwd = ""
                            faceIdEmail = ""
                        }
                        .disabled(!faceIdEnabled)
                    },
                            header: {Text("Face ID Authentication")},
                            footer: {
                        Text("To enable, login with the Use FaceID option enabled.")
                    })
                    
                    Button(action: {
                        viewSelection = "Home"
                        session.logout()
                    }, label: {
                        Text("Logout")
                    })
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(viewSelection: .constant("Setting"))
            .environmentObject(SessionManager())
    }
}
