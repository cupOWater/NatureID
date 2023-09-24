/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tran Quoc Trung
  ID: 3891724
  Created date: 21/09/2023
  Last modified: 24/09/2023
  Acknowledgement:
*/

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
