//
//  CommentDeleteModal.swift
//  NatureID
//
//  Created by Tran Trung on 21/09/2023.
//

import SwiftUI

struct CommentDeleteModal: View {
    var post: Post
    var commentId: String
    
    @Binding var deleteConfirmModal: Bool
    @Binding var deleteConfirmAnimation: Bool
    
    @ObservedObject var postVM: PostViewModel
    
    @State var isDeleted = false

    var body: some View {
        //MARK: - DELETE MODAL
        ZStack{
            VStack{
                Color("modal-overlay")
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Are you sure?")
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .padding()
                    .frame(width: 300)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                VStack {
                    Text("Do you really want to delete this comment? This process cannot be undone")
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 14)
                    
                    HStack{
                        Button {
                            self.deleteConfirmModal.toggle()
                            self.deleteConfirmAnimation.toggle()
                        } label: {
                            Text("Cancel")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 120, height: 40)
                                .background(.gray)
                                .cornerRadius(20)
                        }
                        .disabled(isDeleted)
                        .padding(.leading, 5)
                        .padding(.bottom, 10)
                        .padding(.horizontal, 5)
                        
                        Button {
                            postVM.deleteComment(post: self.post, commentId: self.commentId){ success in
                                self.deleteConfirmModal.toggle()
                                self.deleteConfirmAnimation.toggle()
                            }
                        } label: {
                            Text("Delete")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 120, height: 40)
                                .background(Color("quinary"))
                                .cornerRadius(20)
                            
                        }
                        .disabled(isDeleted)
                        .padding(.trailing, 5)
                        .padding(.bottom, 10)
                        .padding(.horizontal, 5)
                    }
                    .padding(.top, 16)
                }
                Spacer()
            }
            .background()
            .cornerRadius(20)
            .frame(width: 350, height: 220, alignment: .center)
            .onAppear{
                deleteConfirmAnimation.toggle()
            }
            .scaleEffect(deleteConfirmAnimation ? 1 : 0.1)
            .animation(.easeIn, value: deleteConfirmAnimation)
        }
    }
}

struct CommentDeleteModal_Previews: PreviewProvider {
    static var previews: some View {
        CommentDeleteModal(post: Post(), commentId: "test", deleteConfirmModal: .constant(true), deleteConfirmAnimation: .constant(true), postVM: PostViewModel())
    }
}
