//
//  MySettingView.swift
//  HanselAndGretel
//
//  Created by zooey on 2022/11/16.
//

/*
 === NotoSerifKR-Regular
 === NotoSerifKR-ExtraLight
 === NotoSerifKR-Light
 === NotoSerifKR-Medium
 === NotoSerifKR-SemiBold
 === NotoSerifKR-Bold
 === NotoSerifKR-Black
 */


//MARK: 폰트설정 완료

import SwiftUI

struct SettingView: View {
    var body: some View {
        
        
        ZStack {
            Color("White")
                .ignoresSafeArea()
            
            VStack {
                ZStack(alignment: .leading) {
                    MyPath3()
                        .stroke(Color("Pink"))
                    Text("설 정")
                        .font(.custom("NotoSerifKR-Bold",size:40))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("DarkGray"))
                        .padding(EdgeInsets(top: -4, leading: 45, bottom: 0, trailing: 0))
                }
                .frame(height: 50)
                .padding(.bottom, 5)
                
                ScrollView {
                    
                    VStack(spacing: -20) {
                        
                        Button {
                            
                        } label: {
                            
                            ZStack{
                                Image("line")
                                    .resizable()
                                    .frame(width: 110, height: 100)
                                Text("친구 목록")
                                    .font(.custom("NotoSerifKR-Light",size:17))
                                    .foregroundColor(Color("DarkGray"))
                                    .offset(y: -3)
                                
                            }
                        }
                        
                        Button {
                            
                        } label: {
                            NavigationLink(destination: InviteFriendView()){
                                ZStack{
                                    Image("line")
                                        .resizable()
                                        .frame(width: 110, height: 100)
                                    Text("친구 초대")
                                        .font(.custom("NotoSerifKR-Light",size:17))
                                        .foregroundColor(Color("Pink"))
                                        .offset(y: -3)
                                }
                            }
                        }
                        
                        Button {
                            
                        } label: {
                            
                            ZStack{
                                Image("line")
                                    .resizable()
                                    .frame(width: 110, height: 100)
                                Text("알림 설정")
                                    .font(.custom("NotoSerifKR-Light",size:17))
                                    .foregroundColor(Color("DarkGray"))
                                    .offset(y: -3)
                            }
                        }
                        
                        Button {
                            
                        } label: {
                            
                            ZStack{
                                Image("line")
                                    .resizable()
                                    .frame(width: 110, height: 100)
                                Text("개인/보안")
                                    .font(.custom("NotoSerifKR-Light",size:17))
                                    .foregroundColor(Color("DarkGray"))
                                    .offset(y: -3)
                            }
                        }
                        
                        Button {
                            
                        } label: {
                            
                            ZStack{
                                Image("line")
                                    .resizable()
                                    .frame(width: 110, height: 100)
                                Text("공지사항")
                                    .font(.custom("NotoSerifKR-Light",size:17))
                                    .foregroundColor(Color("DarkGray"))
                                    .offset(y: -3)
                            }
                        }
                        NavigationLink(destination:                      OnboardingDescribeView()) {
                            ZStack{
                                Image("line")
                                    .resizable()
                                    .frame(width: 110, height: 100)
                                Text("길라잡이")
                                    .font(.custom("NotoSerifKR-Light",size:17))
                                    .foregroundColor(Color("Pink"))
                                    .offset(y: -3)
                            }
                        }
  
                        
                        NavigationLink(destination: LoginView()) {
                            ZStack{
                                Image("line2")
                                    .resizable()
                                    .frame(width: 110, height: 100)
                                Text("로그아웃")
                                    .font(.custom("NotoSerifKR-Light",size:17))
                                    .foregroundColor(Color("Pink"))
                                    .offset(y: -3)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
