//
//  DrawerDetailView.swift
//  Gilgaon
//
//  Created by 정소희 on 2023/03/04.
//

import SwiftUI

struct DrawerDetailView: View {
    
    @EnvironmentObject var fireStoreViewModel: FireStoreViewModel
    @StateObject var friendViewModel = FriendViewModel()
    @State private var middleView: MiddleView = .schedule
    @Binding var showMenu: Bool
    var middleViewArray: [MiddleView] = [.schedule, .list]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    // profile Image
                    Spacer()
                    VStack {
                        if let url = fireStoreViewModel.profileUrlString,
                           let imageUrl = URL(string: url) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 110, height: 110)
                                    .cornerRadius(64)
                                    .overlay(RoundedRectangle(cornerRadius: 64)
                                        .stroke(Color("Pink"), lineWidth: 3))
                                
                            } placeholder: {
                                
                            }
                        } else{
                            
                            personImage // Image(systemName: "person.fill")
                        }
                        
                    }
                    //                        .offset(x: -65)
                    Spacer()
                    VStack(alignment: .leading) {
                        
                        userNickNameText // fireStoreViewModel.userNickName
                        
                        NavigationLink {
//                            AddFriendView(friendViewModel: friendViewModel)
                            FriendSettingView()
                        } label: {
                            
                            Text("\(fireStoreViewModel.myFriendArray.count)명의 친구")
                                .font(.custom("NotoSerifKR-Regular",size:16))
                            
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    ForEach(middleViewArray, id: \.self) { select in
                        ZStack {
                            Button {
                                middleView = select
                            } label: {
                                Text(select.rawValue)
                                    .foregroundColor(middleView == select ? Color("Pink") : Color("DarkGray"))
                                    .font(.custom("NotoSerifKR-Regular",size:16))
                            }
                            
                            
                            if middleView == select {
                                Capsule()
                                    .foregroundColor(Color("Red"))
                                    .frame(height: 3)
                                    .offset(y: 17)
                            }
                            
                        }
                        .frame(width: geometry.size.width/2.4)
                    }
                }
                
                switch middleView {
                case .schedule:
                    DrawerScheduleView()
                case .list:
                    DrawerListView()
                }
            }
        }
    }
}

extension DrawerDetailView {
    
    private var personImage: some View {
        Image(systemName: "person.fill")
            .foregroundColor(Color("Pink"))
            .font(.system(size: 64))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 64)
                .stroke(Color("Pink"), lineWidth: 3))
    }
    
    private var userNickNameText: some View {
        Text(fireStoreViewModel.userNickName)
            .font(.custom("NotoSerifKR-Regular",size:25))
            .foregroundColor(Color("DarkGray"))
            .bold()
            .padding(.bottom, 10)
    }
}

struct DrawerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerDetailView(showMenu: .constant(true))
    }
}
