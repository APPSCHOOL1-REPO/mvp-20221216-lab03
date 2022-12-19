//
//  OnboardingTabView.swift
//  Onboard
//
//  Created by kimminho on 2022/12/01.
//

import SwiftUI

struct OnboardingTabView: View {
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        TabView {
            // 페이지 1: 앱 소개
            OnboardingDescribeView()
            // 페이지 2: 카메라,위치추적 활성화
            GilgaonRequestPermissonView(isFirstLaunching: $isFirstLaunching)
            
            
            
            
            
            
            
//            OnboardingPageView(
//                imageName: "person.3.fill",
//                title: "놀라운 개발자 커뮤니티",
//                subtitle: "질문을 던지고, 다른 사람의 답변을 확인하세요"
//            )
            // 페이지 2: 쓰기 페이지 안내
//            OnboardingPageView(
//                imageName: "note.text.badge.plus",
//                title: "쓰기 탭",
//                subtitle: "이 앱은 개인 메모장으로도 쓸 수 있어요"
//            )
            
            // 페이지 3: 읽기 페이지 안내 + 온보딩 완료
//            OnboardingLastPageView(
//                imageName: "eyes",
//                title: "읽기 탭",
//                subtitle: "시행착오를 정리해서 공유하고, 다른 개발자들의 인사이트를 얻으세요",
//                isFirstLaunching: $isFirstLaunching
//            )
        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}
