//
//  CommentViewModel.swift
//  NatureID
//
//  Created by Trung Tran Quoc on 15/09/2023.
//

import Foundation

class CommentViewModel: ObservableObject{
    @Published var comment: Comment = Comment()
    
    func upVote(){
        comment.vote += 1
    }
    
    func downVote(){
        comment.vote -= 1
    }
}
