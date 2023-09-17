//
//  UserView.swift
//  NatureID
//
//  Created by MacNCheese on 14/09/2023.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var session : SessionManager
    var user : User
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                VStack (alignment: .leading) {
                    if(session.user.id ?? "" == user.id){
                        HStack {
                            Spacer()
                            NavigationLink {
                                UserEditView(editUser: user)
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .fontWeight(.bold)
                                    .frame(width: 30)
                            }
                        }
                    }
                    
                    AsyncImage(url: URL(string: user.photoUrl)){image in
                        image
                            .resizable()
                    } placeholder: {
                        Image("placeholder-person")
                            .resizable()
                    }
                    .modifier(ProfilePhotoStyle())
                    
                    Text(user.userName)
                        .font(.largeTitle)
                    Text(user.email)
                        .font(.caption)
                        .opacity(0.6)
                    Text(user.bio)
                        .font(.callout)
                        .padding(.top, 5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                
                Divider()
                
                // MARK: Show User's Posts here
                Spacer()
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(email: "oden@rmen.com", userName: "Bob Odenkirk", bio: "Hello, I am Bob Odenkirk, you may know me through shows like Breaking Bad and Better Call Saul. :)))"))
            .environmentObject(SessionManager())
    }
}
