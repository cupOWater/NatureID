//
//  AboutView.swift
//  NatureID
//
//  Created by Khoi Tran Minh on 15/09/2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .frame(width:200, height: 150)
                .cornerRadius(40)
            
            Text("Nature ID")
                .font(.system(size: 40))
                .font(.headline)
                .fontWeight(.heavy)
                
            
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
             
            
            Spacer()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
