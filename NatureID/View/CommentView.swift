//
//  CommentView.swift
//  NatureID
//
//  Created by Hồ Thuỳ An on 14/09/2023.
//

import SwiftUI
import UIKit

struct CommentView: View {
    
    @ObservedObject var postVM : PostViewModel
    @EnvironmentObject var session : SessionManager
    
    @State var isVotedUp : Bool = false
    @State var isVotedDown : Bool = false
    @State var isVoteDisabled : Bool = false
    
    var comment : Comment
    var post: Post
    var currentUser: User
    
    init(postVM: PostViewModel, comment: Comment, post: Post, currentUser: User) {
        self._postVM = ObservedObject(wrappedValue: postVM)
        self.comment = comment
        self.post = post
        self.currentUser = currentUser
        
        if comment.upVotedUserIds.first(where: {$0 == currentUser.id}) == nil {
            self._isVotedUp = State(wrappedValue:false)
        }else{
            self._isVotedUp = State(wrappedValue:true)
        }
        
        if comment.downVotedUserIds.first(where: {$0 == currentUser.id}) == nil {
            self._isVotedDown = State(wrappedValue:false)
        }else{
            self._isVotedDown = State(wrappedValue:true)
        }
    }
      
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                AsyncImage(url: URL(string: session.user.photoUrl)){image in
                    image
                        .resizable()
                        .cornerRadius(100)
                        .frame(width: 32, height:32)
                } placeholder: {
                    Image("placeholder-person")
                        .resizable()
                        .cornerRadius(100)
                        .frame(width: 32, height:32)
                }
                Text("\(session.user.userName)")
                    .foregroundColor(.gray)
                Spacer()
                Text(comment.createdAt, format: .dateTime.day().month().year())
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 15.0)
            
            Text(comment.content!)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 3)
                .padding(.horizontal, 18)
            
            HStack{
                Spacer()
                //MARK: - UP VOTE BTN
                Button{
                    isVoteDisabled = true
                    if isVotedUp{ //Case user voted up this cmt -> remove upvote
                        postVM.removeUpVotedUser(post: self.post,
                                                 userId: session.user.id!,
                                                 commentId: comment.id) {success in
                            if (success) {isVotedUp.toggle()}
                            isVoteDisabled = false
                        }
                    }else if(!isVotedUp && isVotedDown) { //Case user voted down this cmt -> remove downvote, add upvote
                        postVM.removeDownAddUp(post: self.post,
                                               userId: session.user.id!,
                                               commentId: comment.id) {success in
                            if (success) {
                                isVotedUp.toggle()
                                isVotedDown.toggle()
                            }
                            isVoteDisabled = false
                        }
                    }else{ //Case user not voted up this cmt -> add upvote
                        postVM.addUpVotedUser(post: self.post,
                                              userId: session.user.id!,
                                              commentId: comment.id) {success in
                            if (success) {isVotedUp.toggle()}
                            isVoteDisabled = false
                        }
                    }
                }label:{
                    Image(systemName: isVotedUp ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .foregroundColor(isVotedUp ? Color("primary") : nil)
                }.disabled(isVoteDisabled)
                
                Text("\(comment.upVotedUserIds.count - comment.downVotedUserIds.count)")
                
                //MARK: - DOWN VOTE BTN
                Button{
                    isVoteDisabled = true
                    if isVotedDown{ //Case user voted down this cmt -> remove downvote
                        postVM.removeDownVotedUser(post: self.post,
                                                   userId: session.user.id!,
                                                   commentId: comment.id) {success in
                            if (success) {isVotedDown.toggle()}
                            isVoteDisabled = false
                        }
                    }else if(!isVotedDown && isVotedUp){ //Case user voted up this cmt -> remove upvote, add downvote
                        postVM.removeUpAddDown(post: self.post,
                                               userId: session.user.id!,
                                               commentId: comment.id) {success in
                            if (success) {
                                isVotedUp.toggle()
                                isVotedDown.toggle()
                            }
                            isVoteDisabled = false
                        }
                    }else{ //Case user not voted down this cmt -> add downvote
                        postVM.addDownVotedUser(post: self.post,
                                                userId: session.user.id!,
                                                commentId: comment.id) {success in
                            if (success) {isVotedDown.toggle()}
                            isVoteDisabled = false
                        }
                    }
                }label:{
                    Image(systemName: isVotedDown ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .foregroundColor(isVotedDown ? Color("quaternary") : nil)
                }.disabled(isVoteDisabled)
                
            }
            .padding(.trailing, 15)
            .buttonStyle(PlainButtonStyle())

        }
        .padding(.vertical)
        .background(Color("post-background"))
        .frame(maxWidth: 700)
        .cornerRadius(10)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(postVM: PostViewModel(),
                    comment: Comment(),
                    post: Post(),
                    currentUser: User())
        .environmentObject(SessionManager())
    }
}
