//
//  ContentView.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State var viewSelection : String = "Home"

    
    
    var body: some View {
        VStack {
            // MARK: LOGO
            ZStack {
                Color("primary")
                .edgesIgnoringSafeArea(.all)
                HStack {
                }
            }
            .frame(height: 50)
            
            
            // MARK: Tab View
            TabView(selection: $viewSelection) {
                Text("Home")
                    .tag("Home")
                Text("Personal")
                    .tag("Posts")
                Text("About")
                    .tag("About")
                Text("Setting")
                    .tag("Setting")
            }.tabViewStyle(.page)
            
            
            // MARK: Nav Buttons
            ZStack {
                Color("primary")
                    .edgesIgnoringSafeArea(.all)
                
                HStack {
                    NavbarButton(tag: $viewSelection, tagName: "Home", imgSysName: "house")
                    Spacer()
                    NavbarButton(tag: $viewSelection, tagName: "Posts", imgSysName: "person")
                    Spacer()
                    
                    // MARK: Create post
                    // Show create post sheet
                    Button {
                        
                    } label: {
                        Circle()
                            .fill(Color(.white))
                            .overlay {
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .foregroundColor(Color("primary"))
                                    
                                ZStack {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .padding(10)
                                        .fontWeight(.bold)
                                    .foregroundColor(Color("primary"))
                                }
                            }
                            .offset(y: -14)
                            .scaleEffect(1.5)
                    }

                    
                    Spacer()
                    NavbarButton(tag: $viewSelection, tagName: "About", imgSysName: "info.circle")
                    Spacer()
                    NavbarButton(tag: $viewSelection, tagName: "Setting", imgSysName: "gearshape")

                }
                .padding(.top, 7)
                .padding(.horizontal, 30)
            }
            .padding(.bottom, 20)
            .frame(height: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
