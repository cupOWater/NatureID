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
    @EnvironmentObject var session : SessionManager
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 50, height: 32)
                .foregroundColor(colorScheme == .dark ? .blue : .yellow)
                .opacity(0.3)
                .animation(.easeIn(duration: 0.2), value: colorScheme)
            RoundedRectangle(cornerRadius: 30)
                .fill(colorScheme == .dark ? .blue : .yellow)
                .frame(width: 27, height: 27)
                .overlay{
                    colorScheme == .dark ? Image(systemName: "moon.fill")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    :
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                .offset(x: colorScheme == .dark ? 9.5 : -9.5)
                .animation(.easeIn(duration: 0.2), value: colorScheme)
            
        }
        .onTapGesture {
            if(session.user.themeSetting == "Dark"){
                session.updateUserTheme(theme: "Light")
            }else {
                session.updateUserTheme(theme: "Dark")
            }
        }
    }
}

struct darkModeSwitch_Previews: PreviewProvider {
    static var previews: some View {
        DarkModeSwitch()
            .environmentObject(SessionManager())
    }
}
