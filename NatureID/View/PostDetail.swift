//
//  PostDetail.swift
//  NatureID
//
//  Created by Tran Trung on 16/09/2023.
//

import SwiftUI

struct PostDetail: View {
    @EnvironmentObject var session : SessionManager
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var postVM: PostViewModel
    @StateObject var userVM: UserViewModel
    
    @State var isDeleting = false
    @State var deletingId = ""
    @State var deleteModalAnimation = false
    
    var postId: String
    
    init(postId: String, postVM: PostViewModel = PostViewModel(), userVM: UserViewModel) {
        self.postId = postId
        self._postVM = StateObject(wrappedValue: postVM)
        self._userVM = StateObject(wrappedValue: userVM)
        postVM.getPostById(id: postId)
    }
    
    var body: some View {
        ZStack{
            Color("background")
                .edgesIgnoringSafeArea(.all)
            VStack{
                ScrollView{
                    VStack{
                        // MARK: POST - COMMENT
                        PostItem(user: userVM.getUserById(id: postVM.post.userId),
                                 post: postVM.post,
                                 isShowMenu: (postVM.post.userId == session.user.id),
                                 isDetailed: true,
                                 isDeleting: $isDeleting,
                                 deletingPostId: $deletingId,
                                 userVM: userVM)
                    }
                    ForEach(postVM.post.comments){comment in
                        CommentView(postVM: postVM, comment: comment)
                    }
                }
                AddCommentView(postVM: postVM)
            }
            
            
            //MARK: - DELETE MODAL
            if(isDeleting){
                PostDeleteModal(postId: $deletingId,
                                deleteConfirmModal: $isDeleting,
                                deleteConfirmAnimation: $deleteModalAnimation)
                    .onDisappear{
                        if(deletingId != ""){
                            dismiss()
                        }
                    }
            }
        }
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetail(postId: "D5EFDFCC-9146-4D5E-9B3D-B5DF7A54113C", userVM: UserViewModel())
            .environmentObject(SessionManager())
    }
}
