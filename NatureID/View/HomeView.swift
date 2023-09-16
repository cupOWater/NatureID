//
//  HomeView.swift
//  NatureID
//
//  Created by Tran Trung on 16/09/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var postVM: PostViewModel
    @StateObject var userVM: UserViewModel
    
    init(postVM: PostViewModel = PostViewModel(), userVM: UserViewModel = UserViewModel()) {
        self._postVM = StateObject(wrappedValue: postVM)
        self._userVM = StateObject(wrappedValue: userVM)
        postVM.getAllPost()
    }
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(postVM.posts) { post in
                    NavigationLink {
                        PostDetail(postId: post.id, userVM: self.userVM)
                    } label: {
                        PostItem(user: userVM.getUserById(id: post.userId), post: post)
                            .padding(.bottom, 8)
                    }
                    .buttonStyle(PlainButtonStyle()) 
                }
            }
            .padding(.bottom, 60)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
