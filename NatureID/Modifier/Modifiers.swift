//
//  TextFieldModifier.swift
//  NatureID
//
//  Created by MacNCheese on 16/09/2023.
//

import SwiftUI

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 350, maxHeight: 55)
            .padding(.horizontal, 10)
            .textInputAutocapitalization(.never)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("textFieldBG"))
            }
    }
}


struct ProfilePhotoStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 140, height: 140)
            .scaledToFit()
            .clipShape(Circle())
            .shadow(radius: 5)
    }
}


