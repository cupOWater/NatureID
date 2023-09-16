//
//  ContentView.swift
//  NatureID
//
//  Created by MacNCheese on 12/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State var viewSelection : String = "Home"
    @StateObject var userVM = UserViewModel()
    @EnvironmentObject var session : SessionManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // MARK: Tab View
                    TabView(selection: $viewSelection) {
                        Text("Home")
                            .tag("Home")
                        // Text("User")
                        UserView(user: session.user)
                            .tag("Yours")
                        Text("About")
                            .tag("About")
                        Button(action: {
                            session.logout()
                            viewSelection = "Home"
                        }, label: {
                            Text("Logout")
                        })
                        .tag("Setting")
                    }.tabViewStyle(.page)
                    
                    
                    // MARK: Nav Buttons
                    ZStack {
                        Color("primary")
                            .edgesIgnoringSafeArea(.all)
                        
                        HStack {
                            // Show all posts in created order
                            // show image and post description
                            // Truncate if too long
                            // Allow filtering based on
                            // Search Description
                            // Category
                            
                            // On Click, show post
                            // Post can filter comments by vote
                            // Show full post detail
                            NavbarButton(tag: $viewSelection, tagName: "Home", imgSysName: "house")
                            Spacer()
                            
                            // Show only your posts
                            // Same filtering options as above
                            // (Advance) Use same view to view other users profiles
                            NavbarButton(tag: $viewSelection, tagName: "Yours", imgSysName: "person")
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
                            
                            // Team detail, App detail
                            NavbarButton(tag: $viewSelection, tagName: "About", imgSysName: "info.circle")
                            
                            Spacer()
                            // Change personal details, theme mode, logout
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionManager())
    }
}
