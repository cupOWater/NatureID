/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tran Quoc Trung
  ID: 3891724
  Created date: 16/09/2023
  Last modified: 24/09/2023
  Acknowledgement:
*/

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session : SessionManager
    
    @ObservedObject var postVM: PostViewModel
    @ObservedObject var userVM: UserViewModel
    @State var isDeleting = false
    @State var deletingId = ""
    @State var deleteModalAnimation = false
    @State var searchText = ""
    @State var filters = [false, false, false, false]
    @State var unidentifiedFilter = false
    
    //Func to apply searching and filtering
    func postFilter() -> [Post]{
        var postList = postVM.posts
        
        if(unidentifiedFilter){
            postList = postList.filter{!$0.isIdentified}
        }
        
        if(!searchText.isEmpty){
            postList = postList.filter{ $0.description.lowercased().contains(searchText.lowercased())}
        }
        
        var selectedFilterChips:[String] = []
        for (index, element) in self.filters.enumerated() {
            if(element){
                selectedFilterChips.append(postTypes[index].lowercased())
            }
        }
        if(!selectedFilterChips.isEmpty){
            postList = postList.filter{ selectedFilterChips.contains($0.category.lowercased())
            }
        }
        
        return postList
    }
    
    var body: some View {
        ZStack{
            //MARK: - HOME VIEW
            ScrollView{
                VStack{
                    //Search bar
                    SearchBar(searchInput: $searchText)
                        .padding(.top)
                        .frame(height: 80)
                    
                    //Filter chips
                    HStack{
                        FilterChip(isSelected: $filters[0], value: postTypes[0])
                        FilterChip(isSelected: $filters[1], value: postTypes[1])
                        FilterChip(isSelected: $filters[2], value: postTypes[2])
                        FilterChip(isSelected: $filters[3], value: postTypes[3])
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 10)
                    
                    //Unidentified filter
                    HStack{
                        Spacer()
                        Text("Unidentified")
                            .fontWeight(.bold)
                            .foregroundColor(Color("secondary"))
                        Button {
                            unidentifiedFilter.toggle()
                        } label: {
                            Image(systemName: unidentifiedFilter ? "checkmark.square" : "square")
                                .foregroundColor(Color("secondary"))
                                .font(.system(size: 30))
                                .bold()
                        }
                        .padding(.leading, -5)
                        .padding(.trailing, 18)
                    }
                    .frame(maxWidth: 700)
                    .padding(.bottom)
                    
                    //Post List
                    ForEach(postFilter()) { post in
                        PostItem(user: userVM.getUserById(id: post.userId),
                                 post: post,
                                 isShowMenu: (post.userId == session.user.id),
                                 isDetailed: false,
                                 isDeleting: $isDeleting,
                                 deletingPostId: $deletingId,
                                 userVM: userVM,
                                 postVM: postVM)
                        .padding(.bottom, 8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 60)
            }
            
            //MARK: - DELETE MODAL
            if(isDeleting){
                PostDeleteModal(postId: $deletingId,
                                deleteConfirmModal: $isDeleting,
                                deleteConfirmAnimation: $deleteModalAnimation,
                                postVM: self.postVM)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(postVM: PostViewModel(), userVM: UserViewModel())
            .environmentObject(SessionManager())

    }
}
