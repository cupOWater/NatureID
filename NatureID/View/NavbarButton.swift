/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Huynh Ky Thanh
  ID: 3884734
  Created date: 12/09/2023
  Last modified: 24/09/2023
  Acknowledgement:
*/

import SwiftUI

struct NavbarButton: View {
    @Binding var tag : String
    var tagName : String
    var imgSysName : String
    
    var body: some View {
            Button {
                withAnimation(.easeInOut){
                    tag = tagName
                }
            } label: {
                VStack {
                    Image(systemName: tag == tagName ? imgSysName + ".fill" : imgSysName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(height: 25)
                    
                    Text(tagName)
                        .font(.caption)
                        .foregroundColor(.white)
                        
                }
                .opacity(tag == tagName ? 1 : 0.7)
        }.frame(width: 50)
            
    }
}

struct NavbarButton_Previews: PreviewProvider {
    static var previews: some View {
        NavbarButton(tag: .constant("Hi"), tagName: "Hi", imgSysName: "house.fill")
    }
}
