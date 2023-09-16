//
//  UserView.swift
//  NatureID
//
//  Created by MacNCheese on 14/09/2023.
//

import SwiftUI

let placeHolderImg = "https://firebasestorage.googleapis.com/v0/b/natureid-e46ed.appspot.com/o/image%2Fplaceholder-person.jpg?alt=media&token=1c54206f-4c2e-410b-833b-cae158c5d6af"

struct UserView: View {
    var user : User
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                VStack (alignment: .leading) {
                    AsyncImage(url: URL(string: user.photoUrl ?? placeHolderImg)){image in
                        image.image?
                            .resizable()
                            .scaledToFit()
                            .background(.black)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }.frame(height: 140)
                    Text(user.userName ?? "")
                        .font(.largeTitle)
                    Text(user.email ?? "")
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
    }
}
