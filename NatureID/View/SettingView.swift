//
//  SettingView.swift
//  NatureID
//
//  Created by MacNCheese on 17/09/2023.
//

import SwiftUI

struct SettingView: View {
    @Binding var viewSelection : String
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var session : SessionManager
    @AppStorage("faceIdEnabled") var faceIdEnabled = false
    @AppStorage("faceIdEmail") var faceIdEmail = ""
    @AppStorage("faceIdPwd") var faceIdPwd = ""
    @State var isAutomatic = false
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                List {
                    Section {
                        HStack {
                            Toggle("Automatic", isOn: $isAutomatic)
                                .onChange(of: isAutomatic) { newValue in
                                    if(newValue){
                                        session.updateUserTheme(theme: "Auto")
                                    }else {
                                        if(colorScheme == .dark){
                                            session.updateUserTheme(theme: "Dark")
                                        }else {
                                            session.updateUserTheme(theme: "Light")
                                        }
                                    }
                                }
                        }
                        if (!isAutomatic) {
                            HStack {
                                Text("Theme Mode")
                                Spacer()
                                DarkModeSwitch()
                            }.padding(.trailing, -2)
                        }
                    } header: {
                        Text("Theme Setting")
                    }

                    
                    
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
            .onAppear{
                if(session.user.themeSetting == "Auto"){
                    isAutomatic = true
                }else {isAutomatic = false}
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
