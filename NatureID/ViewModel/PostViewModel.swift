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
    private var db = Firestore.firestore()
    
    init() {
        getAllPost()
    }
    
    //MARK: - POST FUNCs
    // Save post
    private func savePost(postToSave: Post, completion: @escaping (Bool) -> Void){
        do {
            try db.collection("posts").document(postToSave.id).setData(from: postToSave) { error in
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
    
    // Update post name, description by id
    func updatePost(post: Post, description: String, category: String, completion: @escaping (Bool) -> Void) {
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
    
    // Update post identified status
    func updatePostIdentified(post: Post, status: Bool, completion: @escaping (Bool) -> Void){
        var updatePost = post
        updatePost.isIdentified = status
        
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
    
    //MARK: - POST'S COMMENT FUNCs
    //add new comment
    func addComment(post: Post, content: String, userId: String, completion: @escaping (Bool) -> Void){
        var updatePost = post

        let newComment = Comment(content: content, postId: post.id)
        updatePost.comments.append(newComment)
        savePost(postToSave: updatePost){ result in
            completion(result)
        }
    }
    
    //add up voted users
    func addUpVotedUser(post: Post, userId: String, commentId: String,completion: @escaping (Bool) -> Void){
        var updatePost = post

        var commentToUpdate = updatePost.comments.first{$0.id == commentId}
        if(commentToUpdate == nil){completion(false)}
        
        commentToUpdate?.upVotedUserIds.insert(userId)
        
        if let i = post.comments.firstIndex(where: {$0.id == commentId}){
            updatePost.comments[i] = commentToUpdate!
            savePost(postToSave: updatePost){ result in
                completion(result)
            }
        }
        completion(false)
    }
    
    //add down voted users
    func addDownVotedUser(post: Post, userId: String, commentId:String,completion: @escaping (Bool) -> Void){
        var updatePost = post

        var commentToUpdate = post.comments.first{$0.id == commentId}
        if(commentToUpdate == nil){completion(false)}

        commentToUpdate?.downVotedUserIds.insert(userId)
        
        if let i = updatePost.comments.firstIndex(where: {$0.id == commentId}){
            updatePost.comments[i] = commentToUpdate!
            savePost(postToSave: updatePost){ result in
                completion(result)
            }
        }
        completion(false)
    }
    
    // remove up voted users
    func removeUpVotedUser(post: Post, userId: String, commentId:String, completion: @escaping (Bool) -> Void){
        var updatePost = post

        var commentToUpdate = post.comments.first{$0.id == commentId}
        if(commentToUpdate == nil){completion(false)}
        
        let newUpvoteList = commentToUpdate?.upVotedUserIds.filter{$0 != userId}
        commentToUpdate?.upVotedUserIds = newUpvoteList ?? []
        
        if let i = updatePost.comments.firstIndex(where: {$0.id == commentId}){
            updatePost.comments[i] = commentToUpdate!
            savePost(postToSave: updatePost){ result in
                completion(result)
            }
        }
        completion(false)
    }
    
    // remove down voted users
    func removeDownVotedUser(post: Post, userId: String, commentId:String, completion: @escaping (Bool) -> Void){
        var updatePost = post
        
        var commentToUpdate = post.comments.first{$0.id == commentId}
        if(commentToUpdate == nil){completion(false)}
        
        let newDownvoteList = commentToUpdate?.downVotedUserIds.filter{$0 != userId}
        commentToUpdate?.downVotedUserIds = newDownvoteList ?? []
        
        if let i = updatePost.comments.firstIndex(where: {$0.id == commentId}){
            updatePost.comments[i] = commentToUpdate!
            savePost(postToSave: updatePost){ result in
                completion(result)
            }
        }
        completion(false)
    }
    
    // remove downVote -> add upVote
    func removeDownAddUp(post: Post, userId: String, commentId:String, completion: @escaping (Bool) -> Void){
        var updatePost = post

        var commentToUpdate = post.comments.first{$0.id == commentId}
        if(commentToUpdate == nil){completion(false)}
        
        let newDownvoteList = commentToUpdate?.downVotedUserIds.filter{$0 != userId}
        commentToUpdate?.downVotedUserIds = newDownvoteList ?? []
        commentToUpdate?.upVotedUserIds.insert(userId)

        if let i = updatePost.comments.firstIndex(where: {$0.id == commentId}){
            updatePost.comments[i] = commentToUpdate!
            savePost(postToSave: updatePost){ result in
                completion(result)
            }
        }
        completion(false)
    }
    
    // remove upVote -> add downVote
    func removeUpAddDown(post: Post, userId: String, commentId:String, completion: @escaping (Bool) -> Void){
        var updatePost = post

        var commentToUpdate = post.comments.first{$0.id == commentId}
        if(commentToUpdate == nil){completion(false)}
        
        let newUpvoteList = commentToUpdate?.upVotedUserIds.filter{$0 != userId}
        commentToUpdate?.upVotedUserIds = newUpvoteList ?? []
        commentToUpdate?.downVotedUserIds.insert(userId)

        if let i = updatePost.comments.firstIndex(where: {$0.id == commentId}){
            updatePost.comments[i] = commentToUpdate!
            savePost(postToSave: updatePost){ result in
                completion(result)
            }
        }
        completion(false)
    }
    
    func checkUpvoteState(userId: String, comment: Comment) -> Bool{
        if (comment.upVotedUserIds.first(where: {$0 == userId}) != nil){
            return true
        }
        return false
    }
    
    func checkDownvoteState(userId: String, comment: Comment) -> Bool{
        if (comment.downVotedUserIds.first(where: {$0 == userId}) != nil){
            return true
        }
        return false
    }
    
    // func handle upvoteBtn
    func upvote(userId: String, comment: Comment, post: Post){
        let isVotedUp = checkUpvoteState(userId: userId, comment: comment)
        let isVotedDown = checkDownvoteState(userId: userId, comment: comment)
        
        if isVotedUp{ //Case user voted up this cmt -> remove upvote
            removeUpVotedUser(post: post,
                                     userId: userId,
                                     commentId: comment.id) {success in
            }
        }else if(!isVotedUp && isVotedDown) { //Case user voted down this cmt -> remove downvote, add upvote
            removeDownAddUp(post: post,
                                   userId: userId,
                                   commentId: comment.id) {success in
            }
        }else{ //Case user not voted up this cmt -> add upvote
            addUpVotedUser(post: post,
                                  userId: userId,
                                  commentId: comment.id) {success in
            }
        }
    }
    
    
    // func handle upvoteBtn
    func downVote(userId: String, comment: Comment, post: Post){
        let isVotedUp = checkUpvoteState(userId: userId, comment: comment)
        let isVotedDown = checkDownvoteState(userId: userId, comment: comment)
        
        if isVotedDown{ //Case user voted down this cmt -> remove downvote
            removeDownVotedUser(post: post,
                                       userId: userId,
                                       commentId: comment.id) {success in
            }
        }else if(!isVotedDown && isVotedUp){ //Case user voted up this cmt -> remove upvote, add downvote
            removeUpAddDown(post: post,
                                   userId: userId,
                                   commentId: comment.id) {success in
            }
        }else{ //Case user not voted down this cmt -> add downvote
            addDownVotedUser(post: post,
                                    userId: userId,
                                    commentId: comment.id) {success in
            }
        }
    }
}

