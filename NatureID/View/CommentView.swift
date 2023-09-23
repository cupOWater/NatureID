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
    
    var comment : Comment
    var post: Post
    var user: User
    
    @Binding var isDeleting: Bool
    @Binding var deletingCmtId: String
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                AsyncImage(url: URL(string: user.photoUrl)){image in
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
                Text("\(user.userName)")
                    .foregroundColor(.gray)
                Spacer()
                Text(comment.createdAt, format: .dateTime.day().month().year())
                    .foregroundColor(.gray)
                
                //Comment option menu
                if(session.user.id! == comment.userId!){
                    Menu {
                        Button {
                            deletingCmtId = comment.id
                            isDeleting.toggle()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(Angle(degrees: 90))
                            .font(.title2)
                            .padding(5)
                            .padding(.vertical, 15)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
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
                    postVM.upvote(userId: session.user.id!, comment: self.comment, post: self.post)
                }label:{
                    Image(systemName: postVM.checkUpvoteState(userId: session.user.id!, comment: self.comment) ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .foregroundColor(postVM.checkUpvoteState(userId: session.user.id!, comment: self.comment) ? Color("primary") : nil)
                }
                
                Text("\(comment.upVotedUserIds.count - comment.downVotedUserIds.count)")
                
                //MARK: - DOWN VOTE BTN
                Button{
                    postVM.downVote(userId: session.user.id!, comment: self.comment, post: self.post)
                }label:{
                    Image(systemName: postVM.checkDownvoteState(userId: session.user.id!, comment: self.comment) ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .foregroundColor(postVM.checkDownvoteState(userId: session.user.id!, comment: self.comment) ? Color("quinary") : nil)
                }
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
                    user: User(),
                    isDeleting: .constant(false),
                    deletingCmtId: .constant("test"))
        .environmentObject(SessionManager())
    }
}
