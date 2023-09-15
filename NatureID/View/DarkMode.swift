//
//  DarkMode.swift
//  NatureID
//
//  Created by Khoi Tran Minh on 15/09/2023.
//

import SwiftUI

//MARK: DESIGN DARK MODE
struct IsDarkMode: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        Toggle("Dark Mode", isOn: $isDarkMode).padding([.leading, .trailing], 50)
            
        
        
        
    }
}

struct isDarkMode_Previews: PreviewProvider {
    static var previews: some View {
        IsDarkMode()
    }
}
