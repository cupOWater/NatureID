//
//  PostViewModel.swift
//  NatureID
//
//  Created by Tran Trung on 16/09/2023.
//

import Foundation
import UIKit
import FirebaseFirestore

class PostViewModel : ObservableObject {
    @Published var posts = [Post]()
    @Published var post = Post()
    private var db = Firestore.firestore()
        
    // Create new post function
    func createPost(desription: String, category: String, image: UIImage, userId: String, completion: @escaping (String?) -> Void){
        var newPost = Post()
        newPost.category = category
        newPost.description = desription
        newPost.userId = userId
        
        let imageName = "\(userId)_\(NSDate().timeIntervalSince1970)";
        ImageManager.upload(image: image, name: imageName) { url in
            if let url = url{
                newPost.imageUrl = url.absoluteString
                
                do {
                    try self.db.collection("posts").document(newPost.id).setData(from: newPost, completion: { error in
                        if let error = error{
                            print(error.localizedDescription)
                            completion("Create post fail")
                        }
                    })
                } catch {
                    print(error.localizedDescription)
                    completion("Create post fail")
                }
            }else {
                completion("Upload image failed")
                return
            }
            completion(nil)
        }
        
        
    }
    
    // Get all post
    func getAllPost(){
        db.collection("posts").addSnapshotListener { querySnapshot, error in
            if(error != nil) {
                print(error!.localizedDescription)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No post")
                return
            }
            
            do {
                self.posts = try documents.map({ (queryDocumentSnapshot) -> Post in
                    let post = try queryDocumentSnapshot.data(as: Post.self)
                    return post
                })
                self.posts.sort{$0.createdAt > $1.createdAt}
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // Get post by id
    func getPostById(id: String){
        db.collection("posts").document(id)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
                }
                
                do {
                    let data = try document.data(as: Post.self)
                    self.post = data
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
    
    func addComment(){
        
    }
//    func commentUpVote(commentID){
//        post.comments
//    }
}
