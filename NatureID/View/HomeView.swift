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
    
    init(postVM: PostViewModel = PostViewModel(), userVM: UserViewModel = UserViewModel()) {
        self._postVM = StateObject(wrappedValue: postVM)
        self._userVM = StateObject(wrappedValue: userVM)
        postVM.getAllPost()
    }
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    ForEach(postVM.posts) { post in
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
