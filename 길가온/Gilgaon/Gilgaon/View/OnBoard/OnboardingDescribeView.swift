//
//  OnboardingDescribeView.swift
//  Onboard
//
//  Created by kimminho on 2022/12/01.
//

//감성적이게 작성해보기!
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

import SwiftUI

struct OnboardingDescribeView: View {

    var body: some View {
        
        ZStack {
            Color("White")
                .ignoresSafeArea()
            LottieView2(filename: "Sakura")
                .ignoresSafeArea()
                .offset(x:200,y:-270)
                .frame(width: 2000,height: 1300)
                .opacity(0.6)
       
            VStack(alignment: .center, spacing: 5) {
                Spacer()
                VStack {
                        Text("안녕하세요")
                        .font(.custom("NotoSerifKR-Bold",size:40))
                            .foregroundColor(Color("Pink"))
                            .padding()
                }
//              HStack {
                    Text("“길가온”")
                      .kerning(-0.5)
                      .font(.custom("NotoSerifKR-SemiBold",size:25))
                      .foregroundColor(Color("Pink")) + Text("은 사용자의 위치를")
                      .kerning(-0.5)
                      .foregroundColor(Color("DarkGray"))
                      .font(.custom("NotoSerifKR-Light",size:25))
//                }
                
                VStack(spacing: 5) {
                    Text("실시간으로 추적하여")
                        .kerning(-0.5)
                    Text("지나온 동선을 볼 수 있으며")
                        .kerning(-0.5)
                    Text("장소에 대해 마커를 찍고")
                        .kerning(-0.5)
                    Text("마커에 대한 기록을")
                        .kerning(-0.5)
                    Text("남기는 앱 입니다.")
                        .kerning(-0.5)
                }
                .font(.custom("NotoSerifKR-Light",size:25))
                .foregroundColor(Color("DarkGray"))
                Spacer()
            }
        }
        
    

    }
}

struct OnboardingDescribeView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDescribeView()
    }
}
