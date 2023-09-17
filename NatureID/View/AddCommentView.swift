//
//  AddCommentView.swift
//  NatureID
//
//  Created by Tran Trung on 15/09/2023.
//

import SwiftUI

struct AddCommentView: View {
    @State var comment : Comment
    @State var commentText:String = ""
    var body: some View {
        HStack{
            TextField("Add comment",text: $commentText)
                
                .textFieldStyle(.roundedBorder)
            Button{
                comment.content = commentText
                //add comment function
            }label:{
                Text("Post")
                    .foregroundColor(.white)
                    .padding(8)
            }
            .background(Color("primary"))
            .cornerRadius(13)
        }
        .padding()
    }
}

struct AddCommentView_Previews: PreviewProvider {
    static var previews: some View {
        AddCommentView(comment: Comment())
    }
}
