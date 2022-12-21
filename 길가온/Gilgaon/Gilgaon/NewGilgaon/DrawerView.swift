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
    @StateObject var fireStoreViewModel = FireStoreViewModel()
    @State private var showMenu: Bool = false
    @State private var middleView: MiddleView = .schedule
    
    private var middleViewArray: [MiddleView] = [.schedule, .list]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("White")
                    .ignoresSafeArea()
                
                VStack {
                    Text("닉네임")
                    HStack(spacing: 40) {
                        // profile Image
                        if let url = fireStoreViewModel.profileUrlString,
                           let imageUrl = URL(string: url) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                    .cornerRadius(64)
                                    .overlay(RoundedRectangle(cornerRadius: 64)
                                                        .stroke(Color("Pink"), lineWidth: 3))
                            } placeholder: {
                                
                            }
                        } else{
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("Pink"))
                                .font(.system(size: 64))
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 64)
                                                    .stroke(Color("Pink"), lineWidth: 3))
                        }
                        
                       
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
                print(DateType2String())
            }
            .toolbar {
                Button {
                    self.showMenu.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
        .onAppear{
            fireStoreViewModel.fetchImageUrl()
        }
    }
}

struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView()
    }
}
