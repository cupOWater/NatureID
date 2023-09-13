//
//  NavbarButton.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

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
        }.frame(width: 40)
            
    }
}

struct NavbarButton_Previews: PreviewProvider {
    static var previews: some View {
        NavbarButton(tag: .constant("Hi"), tagName: "Hi", imgSysName: "house.fill")
    }
}
