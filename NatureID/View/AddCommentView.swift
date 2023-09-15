//
//  AddCommentView.swift
//  NatureID
//
//  Created by Tran Trung on 15/09/2023.
//

import SwiftUI

struct AddCommentView: View {
    
    @State var comment:String = ""
    var body: some View {
        HStack{
            TextField("Add comment",text: $comment)
            Button{
                
            }label:{
                Text("Post")
                    .foregroundColor(.white)
                    .background(Color("primary"))
                    .cornerRadius(8)
                    
            }
           
            
        }
        .background(.gray)
        
        
    }
}

struct AddCommentView_Previews: PreviewProvider {
    static var previews: some View {
        AddCommentView()
    }
}
