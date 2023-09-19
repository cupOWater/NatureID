//
//  SearchBar.swift
//  NatureID
//
//  Created by Tran Trung on 17/09/2023.
//

import SwiftUI

struct SearchBar: View {
    @State var isSearching = false
    @Binding var searchInput: String
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchInput)
                .onTapGesture {
                    isSearching = true
                }
                .padding(.vertical, 10)
                .padding(.leading, 36)
                .padding(.trailing, 36)
                .background(Color("textFieldBG"))
                .cornerRadius(12)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if(isSearching) {
                            Button {
                                searchInput = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .padding(.vertical, 10)

            if(isSearching) {
                Button{
                    isSearching = false
                    searchInput = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing, 20)
            }
        }.frame(maxWidth: 600)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchInput: .constant(""))
    }
}
