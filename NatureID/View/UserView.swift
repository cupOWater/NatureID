//
//  UserView.swift
//  NatureID
//
//  Created by MacNCheese on 14/09/2023.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var session : SessionManager
    
    @ObservedObject var postVM: PostViewModel
    @ObservedObject var userVM: UserViewModel
    @State var isDeleting = false
    @State var deletingId = ""
    @State var deleteModalAnimation = false
    @State var searchText = ""
    @State var filters = [false, false, false, false]
    @State var unidentifiedFilter = false

    var user : User
    
    //Func to filter user's posts, apply searching and filtering
    func postFilter() -> [Post]{
        var postList = postVM.posts
        postList = postList.filter{$0.userId == user.id}
        
        if(unidentifiedFilter){
            postList = postList.filter{!$0.isIdentified}
        }
        
        if(!searchText.isEmpty){
            postList = postList.filter{ $0.description.lowercased().contains(searchText.lowercased())}
        }

        var selectedFilterChips:[String] = []
        for (index, element) in self.filters.enumerated() {
            if(element){
                selectedFilterChips.append(postTypes[index].lowercased())
            }
        }

        if(!selectedFilterChips.isEmpty){
            postList = postList.filter{ selectedFilterChips.contains($0.category.lowercased())
            }
        }
        return postList
    }
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                // MARK: - USER INFO
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
                .frame(maxWidth: 700, alignment: .leading)
                .padding(.horizontal, 30)
                
                Divider()
                
                // MARK: - USER POSTS
                VStack{
                    //Search bar
                    SearchBar(searchInput: $searchText)
                        .padding(.top)
                        .frame(height: 80)
                    
                    //Filter chips
                    HStack{
                        FilterChip(isSelected: $filters[0], value: postTypes[0])
                        FilterChip(isSelected: $filters[1], value: postTypes[1])
                        FilterChip(isSelected: $filters[2], value: postTypes[2])
                        FilterChip(isSelected: $filters[3], value: postTypes[3])
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 10)
                    
                    //Unidentified filter
                    HStack{
                        Spacer()
                        Text("Unidentified")
                            .fontWeight(.bold)
                            .foregroundColor(Color("secondary"))
                        Button {
                            unidentifiedFilter.toggle()
                        } label: {
                            Image(systemName: unidentifiedFilter ? "checkmark.square" : "square")
                                .foregroundColor(Color("secondary"))
                                .font(.system(size: 30))
                                .bold()
                        }
                        .padding(.leading, -5)
                        .padding(.trailing, 18)
                    }
                    .frame(maxWidth: 700)
                    .padding(.bottom)
                    
                    //Post List
                    ForEach(postFilter()) { post in
                        PostItem(user: user,
                                 post: post,
                                 isShowMenu: (post.userId == session.user.id),
                                 isDetailed: false,
                                 isDeleting: $isDeleting,
                                 deletingPostId: $deletingId,
                                 userVM: userVM, postVM: postVM, canViewUser : false)
                        .padding(.bottom, 8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 60)
            }
            
            //MARK: - DELETE MODAL
            if(isDeleting){
                PostDeleteModal(postId: $deletingId,
                                deleteConfirmModal: $isDeleting,
                                deleteConfirmAnimation: $deleteModalAnimation,
                                postVM: self.postVM)
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(postVM: PostViewModel(),
                 userVM: UserViewModel(),
                 user: User(email: "oden@rmen.com", userName: "Bob Odenkirk", bio: "Hello, I am Bob Odenkirk, you may know me through shows like Breaking Bad and Better Call Saul. :)))"))
            .environmentObject(SessionManager())
    }
}
