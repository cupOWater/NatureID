//
//  LoginView.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import SwiftUI

struct LoginView: View {
    @State var email : String = ""
    @State var password : String = ""
    var body: some View {
        VStack {
            Image(systemName: "figure.roll")
                .resizable()
            .scaledToFit()
            .frame(width: 120)
            Text("NaturalID")
                .font(.largeTitle)
            
            TextField("Email", text: $email)
                .padding(10)
            TextField("Password", text: $password)
                .padding(10)
            
            // Show register sheet
            
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Text("Register Now!")
                }
            .padding(.top, 20)
            }

        }
        .padding(50)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
