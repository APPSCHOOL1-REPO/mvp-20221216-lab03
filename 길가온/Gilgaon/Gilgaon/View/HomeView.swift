//
//  HomeView.swift
//  HanselAndGretel
//
//  Created by zooey on 2022/11/29.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @State private var selectedTabBar: SelectedTab = .first
    
    var body: some View {
        
        VStack {
            switch selectedTabBar {
            case .first:
                RecordView()
            case .second:
                CalendarView()
            case .third:
                FlowerMapView()
            case .fourth:
                SettingView()
            }
            TabBarView(selectedTabBar: $selectedTabBar)
                .frame(height: 40)
        }
        .navigationBarHidden(true)
        .accentColor(Color("Red"))
        .fullScreenCover(isPresented: $isFirstLaunching) {
            OnboardingTabView(isFirstLaunching: $isFirstLaunching)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
