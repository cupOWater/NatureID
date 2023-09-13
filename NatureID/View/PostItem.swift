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
    var postImgUrl: String

    var body: some View {
        VStack{
            HStack{
                Image(userImgUrl)
                Text(userName)
                    .font(.headline)
            }
            Image(postImgUrl)
        }
    }
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        PostItem(userName: "test name",
                 userImgUrl: "placeholder-person",
                 postImgUrl: "placeholder-person")
    }
}
