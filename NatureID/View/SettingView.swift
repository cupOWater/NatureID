//
//  SettingView.swift
//  NatureID
//
//  Created by Khoi Tran Minh on 15/09/2023.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack{
            
            Image("logo")
                .resizable()
                .frame(width: 200, height:150)
                .padding(.vertical, 6)
            
            IsDarkMode()
                .padding(.horizontal,5)
                .padding(.vertical, 10)
            Spacer()
            
            ZStack{
                
                    
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color("tertiary"))
                    
                Text("LOG OUT")
                    .fontWeight(.bold)
                
                    
            } .frame(width:250, height:50)
            
            
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
