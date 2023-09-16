//
//  LoginView.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var session : SessionManager
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var showRegister = false
    
    let auth = Auth.auth()
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            if(session.isLoading){
                LoadingView()
            }
            VStack {
                Image(systemName: "figure.roll")
                    .resizable()
                .scaledToFit()
                .frame(width: 120)
                Text("NaturalID")
                    .font(.largeTitle)
                
                TextField("Email", text: $email)
                    .modifier(TextFieldStyle())
                
                SecureField("Password", text: $password)
                    .modifier(TextFieldStyle())
                
                // Show register view
                
                HStack {
                    Spacer()
                    Button {
                        showRegister = true
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
                
                Text(errorMessage)
                    .foregroundColor(.gray)
            }
            .padding(25)
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
