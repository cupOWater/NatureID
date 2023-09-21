//
//  LoginView.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @AppStorage("faceIdEnabled") var faceIdEnabled = false
    @AppStorage("faceIdEmail") var faceIdEmail = ""
    @AppStorage("faceIdPwd") var faceIdPwd = ""
    
    @EnvironmentObject var session : SessionManager
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var showRegister = false
    @State private var enableFaceId = false
    
    let auth = Auth.auth()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                if(session.isLoading){
                    LoadingView()
                }
                
                VStack {
                    LogoView()
                        .frame(width: 300)
                        .padding(.bottom, -135)
                    Text("Natural ID")
                        .font(.system(size: 50))
                        .bold()
                    
                    TextField("Email", text: $email)
                        .modifier(TextFieldStyle())
                    
                    SecureField("Password", text: $password)
                        .modifier(TextFieldStyle())
                    
                    // Show register view
                    
                    HStack {
                        Spacer()
                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Register Now!")
                        }
                        .sheet(isPresented: $showRegister, content: {
                            RegisterView()
                        })
                        .padding(.top, 20)
                    }
                    
                    Button {
                        session.login(email: email, password: password) { errMsg in
                            if(errMsg != nil){
                                errorMessage = errMsg!
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                                    errorMessage = ""
                                }
                            } else {
                                if(!faceIdEnabled && enableFaceId){
                                    faceIdEnabled = true
                                    faceIdEmail = email
                                    faceIdPwd = password
                                }
                            }
                        }
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(Color("primary"))
                                .frame(height: 60)
                            Text("Login")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(20)
                        }
                    }
                    .opacity(session.isLoading ? 0.5 : 1)
                    .padding(.top, -7)
                    
                    HStack{
                        if(faceIdEnabled){
                            Button{
                                session.faceIDAuth(email: faceIdEmail, password: faceIdPwd) { errMsg in
                                    if(errMsg != nil){
                                        errorMessage = errMsg!
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                                            errorMessage = ""
                                        }
                                    }
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "faceid")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    Text("Use FaceID")
                                        .opacity(0.8)
                                        .fontWeight(.bold)
                                }
                            }
                        }else {
                            Spacer()
                            Toggle(isOn: $enableFaceId) {
                                Text("Use FaceID")
                                    .opacity(0.8)
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: 150)
                        }
                    }
                    
                    Text(errorMessage)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: 400)
                .padding(25)
            }
        }
        .disabled(session.isLoading)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SessionManager())
    }
}
