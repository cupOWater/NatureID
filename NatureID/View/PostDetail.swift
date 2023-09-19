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
    
    var post: Post
    
    var body: some View {
        ZStack{
            Color("background")
                .edgesIgnoringSafeArea(.all)
            VStack{
                ScrollView{
                    VStack{
                        // MARK: POST - COMMENT
                        PostItem(user: userVM.getUserById(id: post.userId),
                             post: post,
                             isShowMenu: (post.userId == session.user.id),
                             isDetailed: true,
                             isDeleting: $isDeleting,
                             deletingPostId: $deletingId,
                             userVM: userVM,
                             postVM: postVM)
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
        PostDetail(postVM: PostViewModel(),
                   userVM: UserViewModel(),
                   post: Post())
            .environmentObject(SessionManager())
    }
}
