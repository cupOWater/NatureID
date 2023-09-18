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
    
    init() {
        getAllPost()
    }
        
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
    func getPostById(id: String) -> Post{
        let posts = self.posts.filter({$0.id == id})
        if(posts.isEmpty){
            return Post()
        }else {
            return posts[0]
        }
    }
    
    // Update post by id
    func updatePostById(post: Post, description: String, category: String, completion: @escaping (Bool) -> Void) {
        var updatePost = post
        updatePost.category = category
        updatePost.description = description
        
        do {
            try db.collection("posts").document(updatePost.id).setData(from: updatePost) { error in
                if(error != nil){
                    print(error!)
                    completion(false)
                    return
                }else {
                    completion(true)
                }
            }
        } catch {
            print(error)
            completion(false)
        }
    }
    
    // Delete post by id
    func deletePostById(postId: String, completion: @escaping (Bool) -> Void) {
        db.collection("posts").document(postId).delete(){ error in
            if(error != nil){
                print(error!)
                completion(false)
                return
            }else {
                completion(true)
            }
        }
    }
}
