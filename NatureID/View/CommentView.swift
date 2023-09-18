//
//  CommentView.swift
//  NatureID
//
//  Created by Hồ Thuỳ An on 14/09/2023.
//

import SwiftUI
import UIKit

struct CommentView: View {
    
//    @StateObject var commentVM : CommentViewModel = CommentViewModel()
    @StateObject var postVM : PostViewModel = PostViewModel()
    @State var isVotedUp : Bool = false
    @State var isVotedDown : Bool = false
    
    var comment : Comment = Comment()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image("placeholder-person")
                    .resizable()
                    .cornerRadius(100)
                    .frame(width: 32, height:32)
                Text("User name")
                    .foregroundColor(.gray)
                Spacer()
                Text("23/09/2023")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 15.0)
            
            Text("\((postVM.post.comments.first{$0.id == comment.id}?.content)!)")
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
                        isVotedUp.toggle()
                    }else{
                        if isVotedDown{
                            postVM.commentUpVote(commentId:comment.id , completion: {success in
                                if success
                                {print("upvoted")}
                            })
                            isVotedDown.toggle()
                        }
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
                Text("\(postVM.post.comments.first{$0.id == comment.id}!.vote)")
                Button{
                    if isVotedDown{
                        postVM.commentUpVote(commentId:comment.id , completion: {success in
                            if success
                            {print("upvoted")}
                        })
                        isVotedDown.toggle()
                    }else{
                        if isVotedUp{
                            postVM.commentDownVote(commentId:comment.id , completion: {success in
                                if success
                                {print("downvoted")}
                            })
                            isVotedUp.toggle()
                        }
                        postVM.commentDownVote(commentId:comment.id , completion: {success in
                            if success
                            {print("downvoted")}
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
        CommentView()
    }
}
