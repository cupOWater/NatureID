//
//  SplashScreenView.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @Binding var splashScreen : Bool
    @State var size = 0.5
    @State var opacity = 0.5
    
    var body: some View {
        ZStack {
            Color("primary")
                .edgesIgnoringSafeArea(.all)
            
            Image(systemName: "hare.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .foregroundColor(.white)
                .scaleEffect(size)
                .opacity(opacity)
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
