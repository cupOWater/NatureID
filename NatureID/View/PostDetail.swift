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
    
    @ObservedObject var postVM: PostViewModel
    @ObservedObject var userVM: UserViewModel
    
    @State var isDeleting = false
    @State var deletingId = ""
    @State var deleteModalAnimation = false
    @State var post: Post
    
    var postId: String
    
    init(postId: String, postVM: PostViewModel, userVM: UserViewModel) {
        self.postId = postId

        self._postVM = ObservedObject(wrappedValue: postVM)
        self._userVM = ObservedObject(wrappedValue: userVM)
        self._post = State(wrappedValue: postVM.getPostById(id: postId))
    }
    
    var body: some View {
        ZStack{
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack{
                    // MARK: POST - COMMENT
                    PostItem(user: userVM.getUserById(id: post.userId),
                             post: post,
                             isShowMenu: (postVM.post.userId == session.user.id),
                             isDetailed: true,
                             isDeleting: $isDeleting,
                             deletingPostId: $deletingId,
                             userVM: userVM,
                             postVM: postVM)
                }
            }
            
            //MARK: - DELETE MODAL
            if(isDeleting){
                PostDeleteModal(postId: $deletingId,
                                deleteConfirmModal: $isDeleting,
                                deleteConfirmAnimation: $deleteModalAnimation,
                                postVM: postVM)
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
        PostDetail(postId: "", postVM: PostViewModel(), userVM: UserViewModel())
            .environmentObject(SessionManager())
    }
}
