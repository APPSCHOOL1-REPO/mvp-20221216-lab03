//
//  DrawerView.swift
//  Gilgaon
//
//  Created by zooey on 2022/12/19.
//
// MARK: -준수 수정함
import SwiftUI
import PhotosUI

enum MiddleView: String {
    case schedule = "꽃갈피"
    case list = "서랍"
}

struct DrawerView: View {
    @State private var showMenu: Bool = false
    @State private var middleView: MiddleView = .schedule
    @EnvironmentObject var fireStoreViewModel: FireStoreViewModel
    
    // 프로필 편집 모드
    @State private var photoEditing: Bool = false
    @State private var showPicker: Bool = false
    @State private var profileImage: UIImage? = nil
    @State var userProfile: FireStoreModel?

    
    private var middleViewArray: [MiddleView] = [.schedule, .list]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("White")
                    .ignoresSafeArea()
                
                VStack {
 
                    HStack {
                        // profile Image
                        Spacer()
                        
                        VStack {
                            
                            ZStack {
                                Button {
                                    photoEditing.toggle()
                                } label: {
                                    
                                    if profileImage == nil {
                                        if let url = fireStoreViewModel.profileUrlString,
                                           let imageUrl = URL(string: url) {
                                            AsyncImage(url: imageUrl) { image in
                                                image
                                                    .resizable()
                                                    .clipShape(Circle())
                                                    .frame(width: 110, height: 110)
                                                    .overlay(RoundedRectangle(cornerRadius: 64)
                                                        .stroke(Color("Pink"), lineWidth: 3))
                                                
                                            } placeholder: {
                                                Image(systemName: "person.circle")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundColor(Color("Pink"))
                                                    .frame(width: 110, height: 110)
                                                    .aspectRatio(contentMode: .fit)
                                            }
                                        } else {
                                            Image(systemName: "person.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(Color("Pink"))
                                                .frame(width: 110, height: 110)
                                        }
                                    } else {
                                        if profileImage != nil {
                                            Image(uiImage: profileImage!)
                                                .resizable()
                                                .clipShape(Circle())
                                                .frame(width: 110, height: 110)
                                                .overlay(RoundedRectangle(cornerRadius: 64)
                                                    .stroke(Color("Pink"), lineWidth: 3))
                                        } else {
                                            Image(systemName: "person.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(Color("Pink"))
                                                .frame(width: 110, height: 110)
                                                .aspectRatio(contentMode: .fit)
                                        }
                                    }
                                    
                                }
                                
                                VStack {
                                    // MARK: 프로필 편집 모드 On
                                    if photoEditing == true {
                                        HStack(spacing: 10) {
                                            // 선택된 이미지가 없는 경우
                                            if profileImage == nil {
                                                // 사진 선택 버튼
                                                Button {
                                                    showPicker.toggle()
                                                } label: {
                                                    Text("선택")
                                                        .font(.custom("NotoSerifKR-Regular",size:12))
                                                }
                                                
                                                // 선택된 이미지가 없는 경우
                                            } else {
                                                // 선택 완료 버튼
                                                Button {
                                                    photoEditing = false
                                                    
                                                    
                                                    let userProfile = FireStoreModel(id: fireStoreViewModel.info?.id ?? "", nickName: fireStoreViewModel.userNickName, userPhoto: fireStoreViewModel.info?.userPhoto ?? "", userEmail: fireStoreViewModel.info?.userEmail ?? "")
                                                    Task{
                                                        await fireStoreViewModel.uploadImageToStorage(userImage: profileImage, user: userProfile)
                                                    }
                                                } label: {
                                                    Text("완료")
                                                        .font(.custom("NotoSerifKR-Regular",size:12))
                                                }
                                                
                                            }
                                            
                                            // 선택 취소 버튼
                                            Button(action: {
                                                photoEditing = false
                                                profileImage = nil
                                            }) {
                                                Text("취소")
                                                    .font(.custom("NotoSerifKR-Regular",size:12))
                                            }
                                            
                                        }
                                    }
                                }
                                .offset(y: 70)
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
                                AddFriendView()
                            } label: {
                                
                                Text("\(fireStoreViewModel.myFriendArray.count)명의 친구")
                                    .font(.custom("NotoSerifKR-Regular",size:16))
                                    
                            }
                        }
//                        .offset(x: -30)
                        Spacer()
                    }
                    .padding(.bottom, 30)
                    
                    
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
            .fullScreenCover(isPresented: $showPicker) {
                ImagePicker(image: $profileImage)
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
            fireStoreViewModel.fetchFriend()
        }
    }
}

//struct DrawerView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawerView()
//    }
//}
