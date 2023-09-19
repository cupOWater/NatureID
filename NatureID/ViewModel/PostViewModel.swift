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
    //add new comment
    func addComment(content:String, userId:String, completion: @escaping (Bool) -> Void){
        let newComment = Comment(content: content,postId: self.post.id)
        self.post.comments.append(newComment)
        do {
            try db.collection("posts").document(self.post.id).setData(from: self.post) { error in
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
    //up vote comment
    func commentUpVote(commentId: String, completion: @escaping (Bool) -> Void){
        var commentToUpdate = self.post.comments.first{$0.id == commentId}
        commentToUpdate!.vote += 1
        
        if let i = self.post.comments.firstIndex(where: {$0.id == commentId}){
            self.post.comments[i] = commentToUpdate!
        }
        do {
            try db.collection("posts").document(self.post.id).setData(from: self.post) { error in
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
    //down vote comment
    func commentDownVote(commentId: String, completion: @escaping (Bool) -> Void){
        var commentToUpdate = self.post.comments.first{$0.id == commentId}
        commentToUpdate!.vote -= 1
        
        if let i = self.post.comments.firstIndex(where: {$0.id == commentId}){
            self.post.comments[i] = commentToUpdate!
        }
        do {
            try db.collection("posts").document(self.post.id).setData(from: self.post) { error in
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
    //add up voted users
    func addUpVotedUser(user:User, commentId:String,completion: @escaping (Bool) -> Void){
        var commentToUpdate = self.post.comments.first{$0.id == commentId}
        commentToUpdate?.upVotedUsers?.append(user)
        if let i = self.post.comments.firstIndex(where: {$0.id == commentId}){
            self.post.comments[i] = commentToUpdate!
            do {
                try db.collection("posts").document(self.post.id).setData(from: self.post) { error in
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
    }
    //add down voted users
    func addDownVotedUser(user:User, commentId:String,completion: @escaping (Bool) -> Void){
        var commentToUpdate = self.post.comments.first{$0.id == commentId}
        commentToUpdate?.downVotedUsers?.append(user)
        if let i = self.post.comments.firstIndex(where: {$0.id == commentId}){
            self.post.comments[i] = commentToUpdate!
            do {
                try db.collection("posts").document(self.post.id).setData(from: self.post) { error in
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
    }
    // remove up voted users
    func removeUpVotedUser(user:User, commentId:String,completion: @escaping (Bool) -> Void){
        var commentToUpdate = self.post.comments.first{$0.id == commentId}
        var newVotedUserList = commentToUpdate?.upVotedUsers?.filter{$0.id != user.id}
        commentToUpdate?.upVotedUsers = newVotedUserList
        if let i = self.post.comments.firstIndex(where: {$0.id == commentId}){
            self.post.comments[i] = commentToUpdate!
            do {
                try db.collection("posts").document(self.post.id).setData(from: self.post) { error in
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
    }
    // remove up voted users
    func removeDownVotedUser(user:User, commentId:String,completion: @escaping (Bool) -> Void){
        var commentToUpdate = self.post.comments.first{$0.id == commentId}
        var newVotedUserList = commentToUpdate?.downVotedUsers?.filter{$0.id != user.id}
        commentToUpdate?.downVotedUsers = newVotedUserList
        if let i = self.post.comments.firstIndex(where: {$0.id == commentId}){
            self.post.comments[i] = commentToUpdate!
            do {
                try db.collection("posts").document(self.post.id).setData(from: self.post) { error in
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

