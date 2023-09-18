//
//  UserView.swift
//  NatureID
//
//  Created by MacNCheese on 14/09/2023.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var session : SessionManager
    
    @StateObject var postVM: PostViewModel
    @StateObject var userVM = UserViewModel()
    @State var isDeleting = false
    @State var deletingId = ""
    @State var deleteModalAnimation = false
    @State var searchText = ""
    @State var filters = [false, false, false, false]
    
    init(user: User){
        self.user = user
        
        self._postVM = StateObject(wrappedValue: PostViewModel())
        postVM.getAllPost()
    }
    
    var user : User
    
    func postFilter() -> [Post]{
        
        var postList = postVM.posts
        postList = postList.filter{$0.userId == user.id}
        
        if(!searchText.isEmpty){
            postList = postVM.posts.filter{ $0.description.lowercased().contains(searchText.lowercased())}
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
                VStack{
                    SearchBar(searchInput: $searchText)
                        .padding(.top)
                        .frame(height: 80)
                    
                    HStack{
                        FilterChip(isSelected: $filters[0], value: postTypes[0])
                        FilterChip(isSelected: $filters[1], value: postTypes[1])
                        FilterChip(isSelected: $filters[2], value: postTypes[2])
                        FilterChip(isSelected: $filters[3], value: postTypes[3])
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 10)
                    
                    ForEach(postFilter()) { post in
                        PostItem(user: user,
                                 post: post,
                                 isShowMenu: (post.userId == session.user.id),
                                 isDetailed: false,
                                 isDeleting: $isDeleting,
                                 deletingPostId: $deletingId,
                                 userVM: userVM)
                        .padding(.bottom, 8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
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
