//
//  LoadingView.swift
//  NatureID
//
//  Created by MacNCheese on 16/09/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        // Use in a ZStack
        VStack {
            ProgressView()
                .scaleEffect(1.5)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing, 30)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
