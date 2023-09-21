//
//  LogoView.swift
//  NatureID
//
//  Created by Trung Tran Quoc on 21/09/2023.
//

import SwiftUI

struct LogoView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if(colorScheme == .dark){
            Image("leaves")
                .resizable()
                .scaledToFit()
                .colorInvert()
        }else {
            Image("leaves")
                .resizable()
                .scaledToFit()
                .colorInvert()
                .colorMultiply(Color("primary"))
            
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
