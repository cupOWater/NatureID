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
    
    //Delete post states
    @State var isDeleting = false
    @State var deletingId = ""
    @State var deleteModalAnimation = false
    
    //Delete comment states
    @State var isDeletingCmt = false
    @State var deletingCmtId = ""
    @State var deleteCmtModalAnimation = false
    
    var post: Post
    
    //Func to sort comment by vote number descending
    func sortComment(comments: [Comment]) -> [Comment]{
        var sortedCommentList = comments
        sortedCommentList.sort{
            ($0.upVotedUserIds.count - $0.downVotedUserIds.count) > ($1.upVotedUserIds.count - $1.downVotedUserIds.count)
        }
        return sortedCommentList
    }
    
    var body: some View {
        ZStack{
            Color("background")
                .edgesIgnoringSafeArea(.all)
            VStack{
                ScrollView{
                        // MARK: POST - COMMENT
                        //Post
                        PostItem(user: userVM.getUserById(id: post.userId),
                             post: post,
                             isShowMenu: (post.userId == session.user.id),
                             isDetailed: true,
                             isDeleting: $isDeleting,
                             deletingPostId: $deletingId,
                             userVM: userVM,
                             postVM: postVM)
                        
                        //Comments
                    ForEach(sortComment(comments: self.post.comments)){comment in
                            CommentView(postVM: postVM,
                                        comment: comment,
                                        post: self.post,
                                        user: userVM.getUserById(id: comment.userId!),
                                        isDeleting: $isDeletingCmt,
                                        deletingCmtId: $deletingCmtId)
                        }
                }
                //Comment add
                AddCommentView(postVM: postVM, post: self.post)
            }
            
            
            //MARK: - DELETE POST MODAL
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
            
            //MARK: - DELETE COMMENT MODAL
            if(isDeletingCmt){
                CommentDeleteModal(post: self.post,
                                   commentId: deletingCmtId,
                                   deleteConfirmModal: $isDeletingCmt,
                                   deleteConfirmAnimation: $deleteCmtModalAnimation,
                                   postVM: postVM)
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
