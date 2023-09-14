//
//  RegisterView.swift
//  NatureID
//
//  Created by MacNCheese on 13/09/2023.
//

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-select-pictures-using-photospicker

import SwiftUI
import PhotosUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var userVm : UserViewModel
    @State private var isLoading = false
    @State private var email : String = ""
    @State private var userName : String = ""
    @State private var password : String = ""
    @State private var pfpItem : PhotosPickerItem?
    @State private var pfpImage = UIImage(named: "placeholder-person")
    
    @State var errorMessage = ""
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Register")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                
                ZStack {
                    Image(uiImage: pfpImage!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .background(.black)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                    
                    PhotosPicker(selection: $pfpItem) {
                        Circle()
                            .fill(Color("primary"))
                            .shadow(radius: 7)
                            .frame(width: 70)
                            .overlay {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(16)
                                    .foregroundColor(.white)
                            }
                            .scaledToFit()
                    }
                    .offset(x: 65, y: 80)
                }
                Divider().padding(.vertical, 20)
                
                
                TextField("Email", text: $email)
                    .padding(10)
                    .textInputAutocapitalization(.never)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black)
                            .opacity(0.1)
                    }
                
                TextField("Username", text: $userName)
                    .padding(10)
                    .textInputAutocapitalization(.never)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black)
                            .opacity(0.1)
                    }
                
                SecureField("Password", text: $password)
                    .padding(10)
                    .textInputAutocapitalization(.never)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black)
                            .opacity(0.1)
                    }
                
                Spacer()
                Text(errorMessage)
                Button {
                    isLoading = true
                    if(pfpImage != nil){
                        userVm.register(email: email, userName: userName, password: password, image: pfpImage!){errMsg in
                            isLoading = false
                            if(errMsg != nil){
                                errorMessage = errMsg!
                            }else{
                                dismiss()
                            }
                        }
                        
                    }
                } label: {
                    ZStack {
                        Capsule()
                            .fill(Color("primary"))
                            .frame(height: 60)
                        Text("Sign Up")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(20)
                    }
                }
            }
            .padding(.horizontal, 25)
            .onChange(of: pfpItem) { _ in
                Task {
                    isLoading = true
                    if let data = try? await pfpItem?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            pfpImage = uiImage
                            isLoading = false
                            return
                        }
                    }
                    print("Upload Failed")
                }
            }
        }
        .disabled(isLoading)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(userVm: UserViewModel())
    }
}
