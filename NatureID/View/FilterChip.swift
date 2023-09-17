//
//  FilterChip.swift
//  NatureID
//
//  Created by Tran Trung on 17/09/2023.
//

import SwiftUI

struct FilterChip: View {
    
    @Binding var isSelected: Bool
    let value: String
    
    var body: some View {
        Text(value).lineLimit(1)
            .frame(minWidth: 50, maxWidth: 120)
            .fontWeight(.medium)
            .foregroundColor(!isSelected ? .black : .white)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(isSelected ? Color("quinary") : Color("quaternary"))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.clear, lineWidth: 1.5)
            )
            .onTapGesture {
                isSelected.toggle()
            }
    }
}

struct FilterChip_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            FilterChip(isSelected: .constant(true), value: "test")
            FilterChip(isSelected: .constant(false), value: "test")
        }
    }
}
