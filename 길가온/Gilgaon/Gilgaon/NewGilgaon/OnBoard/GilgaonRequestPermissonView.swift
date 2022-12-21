//
//  GilgaonRequestPermissonView.swift
//  Onboard
//
//  Created by 서광현 on 2022/12/01.
//

import SwiftUI

struct GilgaonRequestPermissonView: View {
    @Binding var isFirstLaunching: Bool
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        
        ZStack {
            Color("White")
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 48.0) {
                Text("**길가온**")
                    .font(.custom("NotoserifKR-Regular", size: 34))
                    .foregroundColor(Color("Pink")) + Text("을 이용하려면 다음이 필요해요.")
                    .font(.custom("NotoSerifKR-Regular", size: 28))
                    .foregroundColor(Color("DarkGray"))
                
                HStack(alignment: .center, spacing: 16.0) {
                    Image(systemName: "location.fill.viewfinder")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text("소중한 하루의 발 자취를 기록할 **위치 접근**을 허용해 주세요.")
                        .font(.custom("NotoSerifKR-Regular", size: 17))
                }
                .foregroundColor(Color("DarkGray"))
                
                HStack(alignment: .center, spacing: 16.0) {
                    Image(systemName: "camera.viewfinder")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Text("추억을 남길 사진촬영을 위해 **카메라 접근**을 허용해 주세요.")
                        .font(.custom("NotoSerifKR-Regular", size: 17))

                }
                .foregroundColor(Color("DarkGray"))
                
                Text("설정하신 모든 접근들은 환경설정에서 변경하실 수 있어요.")
                    .font(.custom("NotoSerifKR-Regular", size: 15))
                    .foregroundColor(Color("DarkGray"))
                
                Button {
                    self.locationFetcher.start()
                    sleep(3)
                    isFirstLaunching = false
                } label: {
                    Text("시작하기")
                        .font(.custom("NotoSerifKR-Bold", size: 20))
                        .frame(maxWidth: .infinity, maxHeight: 30.0, alignment: .center)
                        .foregroundColor(Color("White"))
                        .padding(10.0)
                        .background {
                            Color("Pink")
                        }
                        .cornerRadius(20.0)

                }
                

            }
            .padding(16.0 * 2.0)
        }
    
    }
}

struct GilgaonRequestPermissonView_Previews: PreviewProvider {
    static var previews: some View {
        GilgaonRequestPermissonView(isFirstLaunching: .constant(true))
    }
}
