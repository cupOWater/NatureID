//
//  PostViewModel.swift
//  NatureID
//
//  Created by Trung Tran Quoc on 15/09/2023.
//

import Foundation

class PostViewModel : ObservableObject {
    @Published var posts = [Post]()

}
