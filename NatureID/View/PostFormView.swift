//
//  PostFormView.swift
//  NatureID
//
//  Created by Tran Trung on 16/09/2023.
//

import SwiftUI
import _PhotosUI_SwiftUI

var postTypes = ["Plant", "Animal", "Fungus", "Others"]

struct PostFormView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject private var postVM = PostViewModel()
    @State private var category = "Plant"
    @State private var description = ""
    @State private var imageItem: PhotosPickerItem?
    @State private var image = UIImage(named: "placeholder-post")
    @State private var errorMsg = ""
    
    var user: User
    
    var body: some View {
        ZStack{
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                //MARK: - VIEW HEADER
                HStack{
                    AsyncImage(url: URL(string: user.photoUrl ?? placeHolderImg)){image in
                        image.image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .clipShape(Circle())
                    }
                    
                    Text(user.userName ?? "")
                        .font(.headline)
                    Spacer()
                    
                    //MARK: Post type picker
                    Picker("Type", selection: $category) {
                        ForEach(postTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .pickerStyle(.automatic)
                    
                }
                .padding(.horizontal)
                
                //MARK: - VIEW BODY
                PhotosPicker(selection: $imageItem, matching: .images){
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFit()
                }
                .onChange(of: imageItem) { _ in
                    Task {
                        if let data = try? await imageItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                image = uiImage
                                return
                            }
                        }
                    }
                }
                
                //MARK: Preview elements
                HStack{
                    Text(Date.now, format: .dateTime.day().month().year())
                        .padding(.leading)
                        .font(.footnote)
                    Spacer()
                    Text("0 comments")
                        .padding(.trailing)
                        .font(.footnote)
                }
                
                //MARK: Preview and input field
                VStack(alignment: .leading){
                    Text("[\(category.uppercased())]")
                        .padding(.leading, 10)
                        .padding(.top, 2)
                        .font(.body)
                    TextField("", text: $description, prompt: Text("Anying you want to share"), axis: .vertical)
                        .padding(.leading, 10)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                
                    Text(errorMsg)
                }

                Button {
                    if(image != nil){
                        postVM.createPost(desription: description, category: category, image: image!, userId: user.id!){errMsg in
                            if(errMsg != nil){
                                print("error")
                                errorMsg = errMsg!
                            }else{
                                print("back")
                                dismiss()
                            }
                        }
                        
                    }
                    
                } label: {
                    ZStack {
                        Capsule()
                            .fill(Color("primary"))
                            .frame(height: 50)
                            .padding(.horizontal)
                        Text("Post")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(20)
                    }
                }
            }
            .padding(.vertical)
            .background(Color("post-background"))
            .frame(maxWidth: 500)
            .cornerRadius(10)
        }
    }
}

struct PostFormView_Previews: PreviewProvider {
    static var previews: some View {
        PostFormView(user: User(id: "testId", userName: "Bob Odenkirk", photoUrl: "https://firebasestorage.googleapis.com/v0/b/natureid-e46ed.appspot.com/o/image%2Fplaceholder-person.jpg?alt=media&token=1c54206f-4c2e-410b-833b-cae158c5d6af"))
    }
}
