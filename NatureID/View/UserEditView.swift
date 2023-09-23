//
//  UserEditView.swift
//  NatureID
//
//  Created by MacNCheese on 16/09/2023.
//

import SwiftUI
import PhotosUI

struct UserEditView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var session : SessionManager
    @State var editUser : User
    @State private var pfpItem : PhotosPickerItem?
    @State private var pfpImage : UIImage?
    
    func validate() -> Bool {
        if(editUser.userName == ""){
            return false
        }
        return true
    }
    
    
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            if(session.isLoading){
                LoadingView()
            }
            VStack (alignment: .leading) {
                HStack {
                    Text("Edit Your Profile")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.bottom, 20)

                
                // MARK: Picture Picker for Pfp
                ZStack {
                    if (pfpImage == nil) {
                        AsyncImage(url: URL(string: editUser.photoUrl)){image in
                            image
                                .resizable()
                        } placeholder: {
                            Image("placeholder-person")
                                .resizable()
                        }
                        .modifier(ProfilePhotoStyle())
                    } else {
                        Image(uiImage: pfpImage!)
                            .resizable()
                            .modifier(ProfilePhotoStyle())
                    }
                    
                    PhotosPicker(selection: $pfpItem) {
                        Circle()
                            .fill(Color("primary"))
                            .shadow(radius: 7)
                            .frame(width: 45)
                            .overlay {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                                    .foregroundColor(.white)
                                
                            }
                            .scaledToFit()
                    }
                    .offset(x: 50, y: 55)
                }
                .padding(.bottom, 20)
                .onChange(of: pfpItem) { _ in
                    Task {
                        session.isLoading = true
                        if let data = try? await pfpItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                pfpImage = uiImage
                            }else {
                                print("Upload Failed")
                            }
                        }
                        session.isLoading = false
                    }
                }
                
                
                // MARK: Username Field
                Text("Your Username")
                    .padding(.bottom, -5)
                TextField("User Name", text: $editUser.userName)
                    .modifier(TextFieldStyle())
                if(!validate()){
                    Text("Empty Username")
                        .foregroundColor(.red)
                        .frame(alignment: .trailing)
                }
                
                // MARK: Bio Field
                Text("Biography")
                    .padding(.top, 15)
                    .padding(.bottom, -5)
                TextField("Bio", text: $editUser.bio)
                    .modifier(TextFieldStyle())
                
                
                HStack {
                    Spacer()
                    Button{
                        if(validate()){
                            session.updateUser(user: editUser, image: pfpImage) { success in
                                dismiss()
                            }
                        }
                    }label: {
                        ZStack{
                            Capsule()
                                .fill(Color("primary"))
                                .frame(width: 120, height: 50)
                            Text("Save")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button{
                        dismiss()
                    }label: {
                        ZStack{
                            Capsule()
                                .fill(.gray)
                                .frame(width: 120, height: 50)
                            Text("Cancel")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                }
                .opacity(session.isLoading ? 0.5 : 1)
                .padding(.top, 40)
            }
            .padding(.horizontal, 25)
            .frame(maxWidth: 430)
        }
        .navigationBarBackButtonHidden()
        .interactiveDismissDisabled(session.isLoading)
        .disabled(session.isLoading)
    }
        
}

struct UserEditView_Previews: PreviewProvider {
    static var previews: some View {
        
        UserEditView(editUser: User(userName: "Test Man", photoUrl: "https://firebasestorage.googleapis.com/v0/b/natureid-e46ed.appspot.com/o/image%2F9JFEHhnIM1aaBDskfXvFMOSWZ4b2.jpg?alt=media&token=8529cbef-d718-41ad-b8af-e66b121dbc74", bio: "Cause I'm a Test Maaan"))
            .environmentObject(SessionManager())
    }
}
