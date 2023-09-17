//
//  ImageManager.swift
//  NatureID
//
//  Created by MacNCheese on 13/09/2023.
//  https://designcode.io/swiftui-advanced-handbook-compress-a-uiimage


import SwiftUI
import FirebaseStorage

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

class ImageManager {
    static let storage = Storage.storage()
    
    static func upload(image : UIImage, name : String, completion: @escaping (URL?) -> Void){
        let imageName = name + ".jpg"
        
        let storageRef = storage.reference().child("image/" + imageName)
        
        let resized = image.aspectFittedToHeight(300)
        let data = resized.jpegData(compressionQuality: 0.2)
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
