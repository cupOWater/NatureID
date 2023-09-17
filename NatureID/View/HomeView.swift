//
//  HomeView.swift
//  NatureID
//
//  Created by Tran Trung on 16/09/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session : SessionManager
    
    @StateObject var postVM: PostViewModel
    @StateObject var userVM: UserViewModel
    @State var isDeleting = false
    @State var deletingId = ""
    @State var deleteModalAnimation = false
    @State var searchText = ""
    @State var filters = [false, false, false, false]

    init(postVM: PostViewModel = PostViewModel(), userVM: UserViewModel = UserViewModel()) {
        self._postVM = StateObject(wrappedValue: postVM)
        self._userVM = StateObject(wrappedValue: userVM)
        postVM.getAllPost()
    }
    
    func postFilter() -> [Post]{
        
        var postList = postVM.posts
        
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
            postList = postVM.posts.filter{ selectedFilterChips.contains($0.category.lowercased())
            }
        }
        
        
        print(selectedFilterChips)
        
        return postList
    }
    
    var body: some View {
        ZStack{
            ScrollView{
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
                        PostItem(user: userVM.getUserById(id: post.userId),
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
            .padding(.bottom, 60)
            
            //MARK: - DELETE MODAL
            if(isDeleting){
                PostDeleteModal(postId: $deletingId, deleteConfirmModal: $isDeleting, deleteConfirmAnimation: $deleteModalAnimation)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionManager())

    }
}
