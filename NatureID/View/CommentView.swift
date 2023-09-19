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
    @State var vote : Int = 0
    
    var comment : Comment
    
    init(postVM: PostViewModel, comment: Comment) {
        self._postVM = ObservedObject(wrappedValue: postVM)
        self.comment = comment
        
        if comment.upVotedUserIds.first(where: {$0 != session.user.id}) == nil {
            self._isVotedUp = State(wrappedValue:false)
        }else{
            self._isVotedUp = State(wrappedValue:true)
        }
        
        if comment.downVotedUserIds.first(where: {$0 != session.user.id}) == nil {
            self._isVotedDown = State(wrappedValue:false)
        }else{
            self._isVotedDown = State(wrappedValue:true)
        }
        
        self._vote = State(wrappedValue: (comment.upVotedUserIds.count - comment.downVotedUserIds.count))
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
                Button{
                    if isVotedUp{
                        postVM.commentDownVote(commentId:comment.id , completion: {success in
                            if success
                            {print("downvoted")}
                        })
                        postVM.removeUpVotedUser(userId: session.user.id, commentId: comment.id, completion: {success in
                            if success
                            {print("upVote user removed")}
                        })
                        isVotedUp.toggle()
                    }else{
                        if isVotedDown{
                            postVM.commentUpVote(commentId:comment.id , completion: {success in
                                if success
                                {print("upvoted")}
                            })
                            postVM.removeDownVotedUser(user: session.user, commentId: comment.id, completion: {success in
                                if success
                                {print("downVote user removed")}
                            })
                            isVotedDown.toggle()
                        }
                        postVM.addUpVotedUser(user: session.user, commentId: comment.id, completion: {success in
                            if success
                            {print("upVote user added")}
                        })
                        postVM.commentUpVote(commentId:comment.id , completion: {success in
                            if success
                            {print("upvoted")}
                        })
                        isVotedUp.toggle()
                    }
                }label:{
                    Image(systemName: isVotedUp ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .foregroundColor(isVotedUp ? Color("primary") : .black)
                }
                Text("\(vote)")
                Button{
                    if isVotedDown{
                        postVM.commentUpVote(commentId:comment.id , completion: {success in
                            if success
                            {print("upvoted")}
                        })
                        postVM.removeDownVotedUser(user: session.user, commentId: comment.id, completion: {success in
                            if success
                            {print("downVote user removed")}
                        })
                        isVotedDown.toggle()
                    }else{
                        if isVotedUp{
                            postVM.commentDownVote(commentId:comment.id , completion: {success in
                                if success
                                {print("downvoted")}
                            })
                            postVM.removeUpVotedUser(user: session.user, commentId: comment.id, completion: {success in
                                if success
                                {print("upVote user removed")}
                            })
                            isVotedUp.toggle()
                        }
                        postVM.commentDownVote(commentId:comment.id , completion: {success in
                            if success
                            {print("downvoted")}
                        })
                        postVM.addDownVotedUser(user: session.user, commentId: comment.id, completion: {success in
                            if success
                            {print("downVote user added")}
                        })
                        isVotedDown.toggle()
                    }
                }label:{
                    Image(systemName: isVotedDown ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .foregroundColor(isVotedDown ? Color("quaternary") : .black)
                }
            }.padding(.trailing, 15)
               
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(postVM: PostViewModel(),
                    comment: Comment())
    }
}
