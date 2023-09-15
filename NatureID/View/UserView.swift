//
//  UserView.swift
//  NatureID
//
//  Created by MacNCheese on 14/09/2023.
//

import SwiftUI

let placeHolderImg = "https://firebasestorage.googleapis.com/v0/b/natureid-e46ed.appspot.com/o/image%2Fplaceholder-person.jpg?alt=media&token=1c54206f-4c2e-410b-833b-cae158c5d6af"

struct UserView: View {
    @StateObject var userVm : UserViewModel
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                VStack {
                    AsyncImage(url: URL(string: userVm.user.photoUrl ?? placeHolderImg)){image in
                        image.image?
                            .resizable()
                            .scaledToFit()
                            .background(.black)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }.frame(height: 140)
                    Text(userVm.user.userName ?? "")
                        .font(.largeTitle)
                    Text(userVm.user.email ?? "")
                        .font(.caption)
                        .opacity(0.6)
                }
                .padding(.horizontal, 10)
                
                Divider()
                
                // MARK: Show User's Posts here
                Spacer()
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userVm: UserViewModel(id: "HYBXaYx5c4NCCPOhvyqSajRQ9tt2"))
    }
}
