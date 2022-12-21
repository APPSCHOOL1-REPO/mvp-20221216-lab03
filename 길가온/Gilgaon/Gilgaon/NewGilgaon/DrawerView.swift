//
//  DrawerView.swift
//  Gilgaon
//
//  Created by zooey on 2022/12/19.
//

import SwiftUI

enum MiddleView: String {
    case schedule = "꽃갈피"
    case list = "서랍"
}

struct DrawerView: View {
    
    @State private var showMenu: Bool = false
    @State private var middleView: MiddleView = .schedule
    @EnvironmentObject var fireStoreViewModel: FireStoreViewModel
   
    
    private var middleViewArray: [MiddleView] = [.schedule, .list]
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("White")
                    .ignoresSafeArea()
                
                VStack {
                    Text(fireStoreViewModel.userNickName)
                    HStack(spacing: 40) {
                        Image("p1")
                            .resizable()
                            .frame(width: 128, height: 128)
                            .clipShape(Circle())
                        
                        NavigationLink {
                            SearchUserView()
                        } label: {
                            Text("친구추가")
                        }
                        
                        
                        NavigationLink {
                            AddFriendView()
                        } label: {
                            Text("친구목록")
                        }
                        
                        
                    }
                    .padding()
                    
                    HStack {
                        ForEach(middleViewArray, id: \.self) { select in
                            VStack {
                                Button {
                                    middleView = select
                                } label: {
                                    Text(select.rawValue)
                                        .foregroundColor(middleView == select ? Color("Pink") : Color("DarkGray"))
                                }
                                if middleView == select {
                                    Capsule()
                                        .foregroundColor(Color("Red"))
                                        .frame(height: 3)
                                }
                            }
                            .frame(width: 160)
                        }
                    }
                    
                    switch middleView {
                    case .schedule:
                        DrawerScheduleView()
                    case .list:
                        DrawerListView()
                    }
                }
                GeometryReader { _ in
                    HStack {
                        Spacer()
                        DrawerSettingView()
                            .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                            .animation(.easeInOut(duration: 0.3), value: showMenu)
                    }
                    
                }
                .background(Color("DarkGray").opacity(showMenu ? 0.5 : 0))
                
            }
            .onAppear {
//                myInfo(fireStoreViewModel.currentUserId!)
                fireStoreViewModel.myInfo(fireStoreViewModel.currentUserId!)
            }
            .toolbar {
                Button {
                    self.showMenu.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
    }
}

struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView()
    }
}
