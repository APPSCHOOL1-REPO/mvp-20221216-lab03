//
//  DrawerScheduleView.swift
//  Gilgaon
//
//  Created by zooey on 2022/12/19.
//

import SwiftUI

struct DrawerScheduleView: View {
    var body: some View {
        ZStack {
            
            Color("White")
                .ignoresSafeArea()
            VStack{
                Text("남겨지는 꽃갈피가 없습니다.")
            }
        }
    }
}

struct DrawerScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerScheduleView()
    }
}
