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

struct SplashScreenView: View {
    @Binding var splashScreen : Bool
    @State var size = 0.5
    @State var opacity = 0.5
    
    var body: some View {
        ZStack {
            Color("primary")
                .edgesIgnoringSafeArea(.all)
            
            Image("leaves")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 400)
                .scaleEffect(size)
                .opacity(opacity)
                .colorInvert()
                .padding(.horizontal, 80)
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 1)){
                size = 2
                opacity = 1
            }
            withAnimation(.easeInOut(duration: 1.5)){
                size = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    splashScreen = false
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(splashScreen: .constant(true))
    }
}
