//
//  DrawerSettingView.swift
//  Gilgaon
//
//  Created by zooey on 2022/12/19.
//

import SwiftUI

struct DrawerSettingView: View {
    @EnvironmentObject var registerModel: RegisterModel
    
    
    var body: some View {
        
        
        VStack {
            
            Text("설정")
                .foregroundColor(Color("DarkGray"))
                .font(.custom("NotoSerifKR-Bold", size: 30))
            
            Divider()
                .frame(width: 140, height: 2)
                .background(Color("DarkGray"))
                .padding(.horizontal, 16)
            
            Button {
                registerModel.logout()
            } label: {
                Text("로그아웃")
                    .foregroundColor(Color("DarkGray"))
                    .font(.custom("NotoSerifKR-Regular",size:16))
                    
            }
            .padding()
            
            Spacer()
        }
        .padding(32)
        .background(Color("White"))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct DrawerSettingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerSettingView()
    }
}
