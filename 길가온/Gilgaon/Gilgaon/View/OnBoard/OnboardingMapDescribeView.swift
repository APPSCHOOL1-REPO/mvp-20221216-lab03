//
//  OnboardingMapDescribeView.swift
//  Gilgaon
//
//  Created by sehooon on 2022/12/22.
//

import SwiftUI

struct OnboardingMapDescribeView: View {
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
                        Text("꽃갈피")
                        .font(.custom("NotoSerifKR-Bold",size:40))
                            .foregroundColor(Color("Pink"))
                            .padding()
                }
                VStack() {
                    ZStack{
                        Image("flowerPink")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 100)
                        Circle()
                            .stroke(lineWidth: 4)
                            .frame(width: 150)
                            .foregroundColor(Color("Pink"))
                            .rotation3DEffect(Angle(degrees: 85), axis: (x: 1, y: 0, z: 0))
                            .offset(y:50)
                    }
                    .padding(.bottom,50)
                    Text("“꽃갈피”란?")
                      .kerning(-0.5)
                      .font(.custom("NotoSerifKR-SemiBold",size:25))
                      .foregroundColor(Color("Pink")) + Text(" 지나온 동선에 ")
                      .kerning(-0.5)
                      .foregroundColor(Color("DarkGray"))
                      .font(.custom("NotoSerifKR-Light",size:25))
                      
                      
    
                    
                    Text("특별한 기록을 남겨주는 말입니다.")
                        .padding(.top,5)
                        .kerning(-0.5)
                        
                    
                }
                .font(.custom("NotoSerifKR-Light",size:25))
                .foregroundColor(Color("DarkGray"))
                Spacer()
            }
        }
        
    

    }
}

struct OnboardingMapDescribeView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingMapDescribeView()
    }
}
