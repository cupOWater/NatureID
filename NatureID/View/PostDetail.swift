//
//  PostDetail.swift
//  NatureID
//
//  Created by Tran Trung on 16/09/2023.
//

import SwiftUI

struct PostDetail: View {
    @StateObject var postVM: PostViewModel
    @StateObject var userVM: UserViewModel
    
    init(postId: String, postVM: PostViewModel = PostViewModel(), userVM: UserViewModel) {
        self._postVM = StateObject(wrappedValue: postVM)
        self._userVM = StateObject(wrappedValue: userVM)
        postVM.getPostById(id: postId)
    }
    
    var body: some View {
        ZStack{
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack{
                    // MARK: POST - COMMENT
                    PostItem(user: userVM.getUserById(id: postVM.post.userId), post: postVM.post)
                    
                }
            }
        }
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetail(postId: "D5EFDFCC-9146-4D5E-9B3D-B5DF7A54113C", userVM: UserViewModel())
    }
}
