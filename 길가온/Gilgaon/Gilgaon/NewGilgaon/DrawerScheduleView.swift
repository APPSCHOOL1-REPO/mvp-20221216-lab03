//
//  DrawerScheduleView.swift
//  Gilgaon
//
//  Created by zooey on 2022/12/19.
//

import SwiftUI


struct DrawerScheduleView: View {
    @StateObject private var fireStoreViewModel = FireStoreViewModel()
    @State var isRecording: Bool = false
    var body: some View {
        ZStack {
            Color("White")
                .ignoresSafeArea()
            VStack{
                Button {
                    isRecording.toggle()
                    if isRecording == true{
                        //  -> [스케쥴을 추가하는 View] //
                    }
                } label: {
                    Text(isRecording ? "기록멈추기": "기록하기")
                }
                
                flowerWritingView
            }

        }
    }
}

extension DrawerScheduleView {
    
    var flowerWritingView: some View {
        VStack
        {
            if isRecording{
                HStack {
                    Text("꽃갈피 남기는 중...")
                        .font(.custom("NotoSerifKR-Bold", size: 18))
                        .foregroundColor(Color("DarkGray"))
                    Image(systemName: "leaf")
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                        .font(.title2)
                        .foregroundColor(Color("Pink"))
                }
                .padding()
                HStack(spacing: 30) {
                    NavigationLink {
                        WritingView()
                    } label: {
                        Text("새 글작성")
                        
                            .font(.custom("NotoSerifKR-SemiBold", size: 15))
                            .foregroundColor(Color("Pink"))
                    }
                    NavigationLink {
                        FlowerMapView()
                    } label: {
                        Text("지도 보기")
                            .font(.custom("NotoSerifKR-SemiBold", size: 15))
                            .foregroundColor(Color("Pink"))
                    }
                }
            }
            else {
                Text("만들어진 꽃갈피가 없습니다.")
                    .font(.custom("NotoSerifKR-SemiBold", size: 15))
                    .foregroundColor(Color("DarkGray"))
            }
        }
        
    }
    
    
    
    
}
struct DrawerScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerScheduleView()
    }
}
