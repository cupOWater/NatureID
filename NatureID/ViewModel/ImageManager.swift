//
//  ImageManager.swift
//  NatureID
//
//  Created by MacNCheese on 13/09/2023.
//


import SwiftUI
import FirebaseStorage

class ImageManager {
    static let storage = Storage.storage()
    
    static func upload(image : UIImage, name : String, completion: @escaping (URL?) -> Void){
        let imageName = name + ".jpg"
        
        let storageRef = storage.reference().child("image/" + imageName)
        let data = image.jpegData(compressionQuality: 0.5)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        if let data = data {
            storageRef.putData(data, metadata: metadata) {(metadata, error) in
                if let error = error {
                    print(error)
                    completion(nil)
                }
                storageRef.downloadURL { (url, error) in
                    if let url = url{
                        completion(url)
                    }
                    else { completion(nil)}
                }
            }
        }
    }
}
