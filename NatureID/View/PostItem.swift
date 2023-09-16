//
//  PostComponent.swift
//  NatureID
//
//  Created by Tran Trung on 13/09/2023.
//

import SwiftUI

let postPlaceHolderImg = "https://firebasestorage.googleapis.com/v0/b/natureid-e46ed.appspot.com/o/image%2F360_F_268556012_c1WBaKFN5rjRxR2eyV33znK4qnYeKZjm.jpg?alt=media&token=ad08602e-1120-446d-8925-c42c901fb561"

struct PostItem: View {
    var user: User
    var post: Post
    
    var body: some View {
        VStack{
            HStack{
                AsyncImage(url: URL(string: user.photoUrl ?? placeHolderImg)){image in
                    image.image?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .clipShape(Circle())
                }
                Text(user.userName ?? "")
                    .font(.headline)
                Spacer()
                Image(systemName: "ellipsis")
                    .rotationEffect(Angle(degrees: 90))
                    .font(.title2)
                
            }
            .padding(.horizontal)
            .padding(.bottom, 1)
            
            AsyncImage(url: URL(string: post.imageUrl)){image in
                image.image?
                    .resizable()
                    .scaledToFit()
            }
            
            HStack{
                Text(post.createdAt, format: .dateTime.day().month().year())
                    .padding(.leading)
                    .font(.footnote)
                Spacer()
                Text("\(post.comments.count) comments")
                    .padding(.trailing)
                    .font(.footnote)
            }
            
            VStack(alignment: .leading){
                Text("[\(post.category)] \(post.description)")
                    .padding(.leading)
                    .padding(.top, 2)
                    .font(.body)
                    .lineLimit(2)
                HStack{Spacer()}
            }
        }
        .padding(.vertical)
        .background(Color("post-background"))
        .frame(maxWidth: 700)
        .cornerRadius(10)
    }
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        PostItem(user: User(),
                 post: Post(userId: "1"))
    }
}
