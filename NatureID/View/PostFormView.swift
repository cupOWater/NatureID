//
//  PostFormView.swift
//  NatureID
//
//  Created by Tran Trung on 16/09/2023.
//

import SwiftUI

struct PostFormView: View {
    @EnvironmentObject var session : SessionManager

    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                HStack{
                    Image(session.auth.)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .clipShape(Circle())
                    Text(session.auth.currentUser.)
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
}

struct PostFormView_Previews: PreviewProvider {
    static var previews: some View {
        PostFormView()
    }
}
