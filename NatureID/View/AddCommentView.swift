//
//  AddCommentView.swift
//  NatureID
//
//  Created by Tran Trung on 15/09/2023.
//

import SwiftUI

struct AddCommentView: View {
    @EnvironmentObject var session : SessionManager
    
    @State var commentText : String = ""
    @ObservedObject var postVM : PostViewModel
    
    var post: Post
        
    var body: some View {
        HStack{
            TextField("Add comment",text: $commentText)
                .padding(10)
                .background(Color("textFieldBG"))
                .cornerRadius(12)

//                .overlay(RoundedRectangle(cornerRadius: 10))
//                .textFieldStyle(.roundedBorder)
            Button{
                postVM.addComment(post: post,
                                  content: commentText,
                                  userId: session.user.id!) {success in
                    if success{
                        print("comment added")
                    }
                    commentText = ""
                }
            }label:{
                Text("Post")
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(10)
            }
            .background(Color("primary"))
            .cornerRadius(13)
        }
        .padding()
    }
}

struct AddCommentView_Previews: PreviewProvider {
    static var previews: some View {
        AddCommentView(postVM:  PostViewModel(), post: Post())
    }
}
