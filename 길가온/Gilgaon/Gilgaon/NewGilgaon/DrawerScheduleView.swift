//
//  DrawerScheduleView.swift
//  Gilgaon
//
//  Created by zooey on 2022/12/19.
//

import SwiftUI

struct DrawerScheduleView: View {
    @StateObject private var fireStoreViewModel = FireStoreViewModel()
    @State var isStart: Bool = false
    @State var isRecording: Bool = RecordingValue.isRecording
    @State var currentDate = Date()
    @State private var showModal = false
    
    @State private var title: String = ""
    var body: some View {
        ZStack {
            Color("White")
                .ignoresSafeArea()
            VStack{
//                Button {
//                        isRecording.toggle()
//                        RecordingValue.isRecording = isRecording
//                    if isRecording == true{
//                        //  -> [스케쥴을 추가하는 View] //
//                        isStart = true
//                    } else {
//                        fireStoreViewModel.sharedFriendList = []
//                    }
//                } label: {
//                    Text(isRecording ? "기록멈추기": "기록하기")
//                        .font(.custom("NotoSerifKR-Regular",size:16))
//                }
//                .alert("기록을 시작합니다.", isPresented: $isStart, actions: {
//                    TextField("꽃갈피 제목", text: $title)
//                        .font(.custom("NotoSerifKR-Regular",size:16))
//
//                    Button {
//                        showModal.toggle()
//                    } label: {
//                        if fireStoreViewModel.sharedFriendList.isEmpty {
//                            Label("함께", systemImage: "plus")
//                                .foregroundColor(Color("DarkGray"))
//                                .font(.custom("NotoSerifKR-SemiBold", size: 15))
//                        } else {
//                            ForEach(fireStoreViewModel.sharedFriendList, id: \.self) { user in
//                                Text(user.nickName)
//                                    .foregroundColor(Color("DarkGray"))
//                                    .font(.custom("NotoSerifKR-SemiBold", size: 15))
//                            }
//                        }
//                    }
//                    .sheet(isPresented: $showModal) {
//                        AddMarkerFriendView(fireStoreViewModel: fireStoreViewModel)
//                            .presentationDetents([.medium])
//                    }
//
//                    Button("취소",role: .cancel,action: {
//                        isRecording = false
//                        RecordingValue.isRecording = isRecording
//                        title = ""
//                    })
//                    Button("추가", action: {
//
//                        let createdAt = Date().timeIntervalSince1970
//                        let sharedFirend = fireStoreViewModel.sharedFriendList
//                        //민호
//                        let calendar = DayCalendarModel(id: UUID().uuidString, taskDate: currentDate, title: title, shareFriend: sharedFirend, realDate: createdAt)
//
//                        fireStoreViewModel.addCalendar(calendar)
//                        title = ""
//
//                    })
//                }
//                )
//                .font(.custom("NotoSerifKR-Regular",size:16))
                
                flowerWritingView
            }

        }
    }
}

extension DrawerScheduleView {
    
    var flowerWritingView: some View {
        VStack {
            if isRecording {
                Button {
                    isRecording.toggle()
                    fireStoreViewModel.sharedFriendList = []
                } label: {
                    Text("기록멈추기")
                }

                
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
                        WritingView(firestoreViewModel: fireStoreViewModel)
                    } label: {
                        Text("새 글작성")
                        
                            .font(.custom("NotoSerifKR-SemiBold", size: 15))
                            .foregroundColor(Color("Pink"))
                    }
                    NavigationLink {
                        FlowerMapView( getStringValue: fireStoreViewModel.nowCalendarId)
                    } label: {
                        Text("지도 보기")
                            .font(.custom("NotoSerifKR-SemiBold", size: 15))
                            .foregroundColor(Color("Pink"))
                    }
                }
            } else {
//                Text("만들어진 꽃갈피가 없습니다.")
//                    .font(.custom("NotoSerifKR-SemiBold", size: 15))
//                    .foregroundColor(Color("DarkGray"))
                TextField("꽃갈피 제목", text: $title)
                    .font(.custom("NotoSerifKR-Regular",size:16))
                
                Button {
                    showModal.toggle()
                } label: {
                    if fireStoreViewModel.sharedFriendList.isEmpty {
                        Label("함께", systemImage: "plus")
                            .foregroundColor(Color("DarkGray"))
                            .font(.custom("NotoSerifKR-SemiBold", size: 15))
                    } else {
                        ForEach(fireStoreViewModel.sharedFriendList, id: \.self) { user in
                            Text(user.nickName)
                                .foregroundColor(Color("DarkGray"))
                                .font(.custom("NotoSerifKR-SemiBold", size: 15))
                        }
                    }
                }
                
                Button("기록시작하기", action: {

                    let createdAt = Date().timeIntervalSince1970
                    var shareFriend:[String] = []
                    for user in fireStoreViewModel.sharedFriendList {
                        shareFriend.append(user.id)
    
                    }
                    let calendar = DayCalendarModel(id: UUID().uuidString, taskDate: currentDate, title: title, shareFriend: shareFriend, realDate: createdAt)
                    
                    fireStoreViewModel.addCalendar(calendar)
                    title = ""
                    
                    isRecording.toggle()
                })
            }
        }
        .sheet(isPresented: $showModal) {
            AddMarkerFriendView(fireStoreViewModel: fireStoreViewModel)
                .presentationDetents([.medium])
        }
        
    }
    
    
    
    
}
struct DrawerScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerScheduleView()
    }
}
