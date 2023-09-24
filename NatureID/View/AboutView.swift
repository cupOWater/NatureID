/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tran Minh Khoi
  ID: 3916827
  Created date: 15/09/2023
  Last modified: 24/09/2023
  Acknowledgement:
*/


import SwiftUI

struct AboutView: View {
    var body: some View {
        
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            VStack{
                LogoView()
                    .frame(width: 300)
                    .padding(.bottom, -30)
                Text("Natural ID")
                    .font(.system(size: 50))
                    .bold()
                    
                
                VStack(alignment: .leading){
                    
                    HStack {
                        Text("Group Name: ")
                            .fontWeight(.bold)
                        
                        Text("SHAMBLES")
                    }.padding(.vertical,2)
                    
                    //MARK: GROUP MEMBERS
                    
                    Text("Group members:")
                        .fontWeight(.bold)
                    VStack(alignment: .leading) {
                        
                        Text("Tran Quoc Trung - s3891724")
                            .padding(.vertical,-5.0)
                    
                        Text("Huynh Ky Thanh - s3884734")
                            .padding(.bottom,-5.0)
                        Text("Ho Tran Minh Khoi - s3877653")
                            .padding(.bottom,-5.0)
                        Text("Tran Minh Khoi - s3916827")
                            .padding(.bottom,-5.0)
                    }.font(.system(size:15))
                        .fontWeight(.light)
                    
                }
    //            .frame(maxWidth:350, alignment: .leading)
                 
            }.padding(.bottom, 350)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
