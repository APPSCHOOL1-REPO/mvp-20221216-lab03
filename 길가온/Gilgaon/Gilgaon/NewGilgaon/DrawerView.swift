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
    
    @EnvironmentObject var fireStoreViewModel: FireStoreViewModel
    
    @State private var showMenu: Bool = false
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("White")
                        .ignoresSafeArea()
                    //서랍, 꽃갈피 뷰
                    DrawerDetailView(showMenu: $showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    //                    GeometryReader { geometry in
                    HStack {
                        Spacer()
                        if showMenu {
                            //햄버거 메뉴 눌렀을 때 보이는 뷰
                            DrawerSettingView()
                                .frame(width: geometry.size.width/2)
                                .animation(.easeInOut(duration: 0.1), value: showMenu)
                                .transition(.move(edge: .trailing)) //왼쪽에서 스윽 나옴
                                .onTapGesture {
                                    //햄버거 메뉴 뷰 터치하면 화면 안꺼지게
                                    self.showMenu = true
                                }
                        } else{
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("Pink"))
                                .font(.system(size: 64))
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 64)
                                    .stroke(Color("Pink"), lineWidth: 3))
                        }
                        
                    }
                    //                        .offset(x: -65)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(fireStoreViewModel.userNickName)
                            .font(.custom("NotoSerifKR-Regular",size:25))
                            .foregroundColor(Color("DarkGray"))
                            .bold()
                            .padding(.bottom, 10)
                        
                        NavigationLink {
                            FriendSettingView()
                        } label: {
                            
                            Text("\(fireStoreViewModel.myFriendArray.count)명의 친구")
                                .font(.custom("NotoSerifKR-Regular",size:16))
                            
                        }
                    }
                }
                .background(Color("DarkGray").opacity(showMenu ? 0.5 : 0))
                .onTapGesture {
                    //햄버거 메뉴 버튼말고 터치로 닫는 코드
                    if self.showMenu {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                        
                    }
                }
                //                    }
            }
            .onAppear {
                //                myInfo(fireStoreViewModel.currentUserId!)
                fireStoreViewModel.myInfo(fireStoreViewModel.currentUserId!)
                fireStoreViewModel.fetchImageUrl()
                fireStoreViewModel.fetchFriend()
            }
            .toolbar {
                Button {
                    withAnimation {
                        showMenu.toggle()
                    }
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
    }
}

//struct DrawerView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawerView()
//    }
//}
