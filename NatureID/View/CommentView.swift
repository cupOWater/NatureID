//
//  CommentView.swift
//  NatureID
//
//  Created by Hồ Thuỳ An on 14/09/2023.
//

import SwiftUI
import UIKit

struct CommentView: View {
    
    @StateObject var commentVM : CommentViewModel = CommentViewModel()
    @State var isVotedUp : Bool = false
    @State var isVotedDown : Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image("placeholder-person")
                    .resizable()
                    .cornerRadius(100)
                    .frame(width: 32, height:32)
                Text((commentVM.comment.user.userName))
                    .foregroundColor(.gray)
                Spacer()
                Text("23/09/2023")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 15.0)
            
            Text("\(commentVM.comment.content!)")
                .multilineTextAlignment(.leading)
                .padding(.vertical, 3)
                .padding(.horizontal, 18)
            
            HStack{
                Spacer()
                Button{
                    if isVotedUp{
                        commentVM.downVote()
                        isVotedUp.toggle()
                    }else{
                        if isVotedDown{
                            commentVM.upVote()
                            isVotedDown.toggle()
                        }
                        commentVM.upVote()
                        isVotedUp.toggle()
                    }
                }label:{
                    Image(systemName: isVotedUp ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .foregroundColor(isVotedUp ? Color("primary") : .black)
                }
                Text("\(commentVM.comment.vote)")
                Button{
                    if isVotedDown{
                        commentVM.upVote()
                        isVotedDown.toggle()
                    }else{
                        if isVotedUp{
                            commentVM.downVote()
                            isVotedUp.toggle()
                        }
                        commentVM.downVote()
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
