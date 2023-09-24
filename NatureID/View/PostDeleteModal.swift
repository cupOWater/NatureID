/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tran Quoc Trung
  ID: 3891724
  Created date: 17/09/2023
  Last modified: 24/09/2023
  Acknowledgement:
*/

import SwiftUI

struct PostDeleteModal: View {
    @Binding var postId: String
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
                    Text("Do you really want to delete this post? This process cannot be undone")
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 18)
                    
                    HStack{
                        Button {
                            self.postId = ""
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
                            postVM.deletePostById(postId: postId){ success in
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

struct PostDeleteModal_Previews: PreviewProvider {
    static var previews: some View {
        PostDeleteModal(postId: .constant("test"), deleteConfirmModal: .constant(true), deleteConfirmAnimation: .constant(true), postVM: PostViewModel())
    }
}
