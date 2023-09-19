//
//  PostComponent.swift
//  NatureID
//
//  Created by Tran Trung on 13/09/2023.
//

import SwiftUI

struct PostItem: View {
    var user: User
    var post: Post
    var isShowMenu: Bool
    var isDetailed: Bool
    
    @Binding var isDeleting: Bool
    @Binding var deletingPostId: String

    @ObservedObject var userVM: UserViewModel
    @ObservedObject var postVM: PostViewModel
    
    var body: some View {
        ZStack{
            VStack{
                //MARK: - POST HEADER
                HStack{
                    //Post's user img - name
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
                    if(post.isIdentified){
                        Image(systemName: "checkmark.seal")
                            .foregroundColor(.green)
                            .font(.system(size: 30))
                    }
                    
                    //Post option menu
                    if(isShowMenu){
                        Menu {
                            NavigationLink {
                                PostEditView(user: user, post: post, postVM: postVM)
                            } label: {
                                Label("Edit", systemImage: "square.and.pencil")
                            }
                            
                            Button {
                                deletingPostId = post.id
                                isDeleting.toggle()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                postVM.updatePostIdentified(post: self.post,
                                                            status: !post.isIdentified){success in
                                    
                                }
                            } label: {
                                Label(post.isIdentified ? "Unidentified" : "Identified",
                                      systemImage: "checkmark.seal")
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .rotationEffect(Angle(degrees: 90))
                                .font(.title2)
                                .padding(5)
                                .padding(.vertical, 15)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 1)
                
                //MARK: - POST BODY
                if(isDetailed){
                    AsyncImage(url: URL(string: post.imageUrl)){image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image("placeholder-post")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    HStack{
                        Text(post.createdAt, format: .dateTime.day().month().year())
                            .padding(.leading)
                            .font(.footnote)
                        Spacer()
                        Text("\(post.comments.count) comments")
                            .padding(.trailing)
                            .font(.footnote)
                    }
                    
                    VStack(alignment: .leading){
                        Text("[\(post.category.uppercased())] \(post.description)")
                            .padding(.leading)
                            .padding(.top, 2)
                            .font(.body)
                            .lineLimit(2)
                        HStack{Spacer()}
                    }
                } else {
                    NavigationLink {
                        PostDetail(postVM: self.postVM,
                                   userVM: self.userVM,
                                   post: self.post)
                    } label: {
                        VStack{
                            AsyncImage(url: URL(string: post.imageUrl)){image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Image("placeholder-post")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                            HStack{
                                Text(post.createdAt, format: .dateTime.day().month().year())
                                    .padding(.leading)
                                    .font(.footnote)
                                Spacer()
                                Text("\(post.comments.count) comments")
                                    .padding(.trailing)
                                    .font(.footnote)
                            }
                            
                            VStack(alignment: .leading){
                                Text("[\(post.category.uppercased())] \(post.description)")
                                    .padding(.leading)
                                    .padding(.top, 2)
                                    .font(.body)
                                    .lineLimit(2)
                                HStack{Spacer()}
                            }
                        }
                    }
                }
            }
            .padding(.vertical)
            .background(Color("post-background"))
            .frame(maxWidth: 700)
            .cornerRadius(10)
        }
    }
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        PostItem(user: User(),
                 post: Post(userId: "1", isIdentified: true),
                 isShowMenu: true,
                 isDetailed: true,
                 isDeleting: .constant(false),
                 deletingPostId: .constant("test"),
                 userVM: UserViewModel(), postVM: PostViewModel())
    }
}
