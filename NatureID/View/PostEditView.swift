//
//  PostEditView.swift
//  NatureID
//
//  Created by Tran Trung on 17/09/2023.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct PostEditView: View {
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var postVM: PostViewModel
    
    @State private var category: String
    @State private var description: String
    @State private var imageItem: PhotosPickerItem?
    @State private var image = UIImage(named: "placeholder-post")
    @State private var errorMsg = ""
    @State private var isEdited = false
    
    var user: User
    var post: Post
    
    init(user: User, post: Post, postVM: PostViewModel){
        self.user = user
        self.post = post
        self._postVM = ObservedObject(wrappedValue: postVM)
        
        self._category = State(wrappedValue: post.category)
        self._description = State(wrappedValue: post.description)
    }
    
    
    var body: some View {
        ZStack{
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                //MARK: - VIEW HEADER
                HStack{
                    AsyncImage(url: URL(string: user.photoUrl)){image in
                        image
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                    } placeholder: {
                        Image("placeholder-person")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                    }
                    
                    Text(user.userName)
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
                AsyncImage(url: URL(string: post.imageUrl)){image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image("placeholder-post")
                        .resizable()
                        .scaledToFit()
                }
                
                //MARK: Preview elements
                HStack{
                    Text(post.createdAt, format: .dateTime.day().month().year())
                        .padding(.leading)
                        .font(.footnote)
                    Spacer()
                    Text("\(post.comments.count) comments")
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
                    isEdited = true
                    postVM.updatePost(post: post, description: description, category: category){ success in
                        dismiss()
                    }
                } label: {
                    ZStack {
                        Capsule()
                            .fill(Color("primary"))
                            .frame(height: 50)
                            .padding(.horizontal)
                        Text("Update")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(20)
                    }
                }.disabled(isEdited)
            }
            .padding(.vertical)
            .background(Color("post-background"))
            .frame(maxWidth: 500)
            .cornerRadius(10)
        }
    }
}

struct PostEditView_Previews: PreviewProvider {
    static var previews: some View {
        PostEditView(user: User(id: "testId", userName: "Bob Odenkirk", photoUrl: "https://firebasestorage.googleapis.com/v0/b/natureid-e46ed.appspot.com/o/image%2Fplaceholder-person.jpg?alt=media&token=1c54206f-4c2e-410b-833b-cae158c5d6af"), post: Post(), postVM: PostViewModel())
    }
}
