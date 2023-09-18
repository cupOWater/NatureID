/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Tran Quoc Trung
  ID: 3891724
  Created  date: 15/08/2023
  Last modified: 04/09/2023
*/

import SwiftUI

struct DarkModeSwitch: View {
    @AppStorage("isDarkMode") private var isDarkMode = false;

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 70, height: 35)
                .foregroundColor(isDarkMode ? Color.gray : Color("skyBlue"))
                .overlay(
                    HStack {
                        Image(systemName: "moon.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                        Spacer()
                        
                        Image(systemName: "sun.max.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.yellow)
                    }
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                )
            RoundedRectangle(cornerRadius: 30)
                .fill(isDarkMode ? .yellow : .gray)
                .frame(width: 35, height: 35)
                .offset(x: isDarkMode ? 17.5 : -17.5)
                .animation(.easeIn(duration: 0.2), value: isDarkMode)
            
        }
//        .onAppear {
//            isDarkMode = (colorScheme == .dark)
//        }
        .onTapGesture {
            isDarkMode.toggle()           
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)

    }
}

struct darkModeSwitch_Previews: PreviewProvider {
    static var previews: some View {
        DarkModeSwitch()
    }
}
