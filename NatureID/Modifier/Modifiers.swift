/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Huynh Ky Thanh
  ID: 3884734
  Created date: 16/09/2023
  Last modified: 24/09/2023
  Acknowledgement:
*/

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


