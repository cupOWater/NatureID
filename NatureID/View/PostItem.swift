//
//  PostComponent.swift
//  NatureID
//
//  Created by Tran Trung on 13/09/2023.
//

import SwiftUI

struct PostItem: View {
    var userName: String
    var userImgUrl: String
    var post: Post
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(userImgUrl)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .clipShape(Circle())
                Text(userName)
                    .font(.headline)
                Spacer()
                Image(systemName: "ellipsis")
                    .rotationEffect(Angle(degrees: 90))
                    .font(.title2)
                
            }
            .padding(.horizontal)

            Image(post.imageUrl)
                .resizable()
                .scaledToFit()
            
            HStack{
                Text(post.createdAt, format: .dateTime.day().month().year())
                    .padding(.leading)
                    .font(.footnote)
                Spacer()
                Text("\(post.comments.count) comments")
                    .padding(.trailing)
                    .font(.footnote)
            }
            
            Text("[\(post.category)] \(post.description)")
                .padding(.leading)
                .padding(.top, 2)
                .font(.body)
        }
        .padding(.vertical)
        .background(Color("background50"))
    }
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        PostItem(userName: "test name",
                 userImgUrl: "placeholder-person",
                 post: Post())
    }
}
