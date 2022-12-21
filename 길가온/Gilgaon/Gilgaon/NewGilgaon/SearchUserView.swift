//
//  TestListView.swift
//  Gilgaon
//
//  Created by kimminho on 2022/12/20.
//

import SwiftUI
import PopupView

struct SearchUserView: View {
    @State private var user: [String] = ["김민호","전준수","정세훈","한주희"]
    @EnvironmentObject private var firestore: FireStoreViewModel
    @State private var searchText: String = ""
    @State var shouldBottomToastMessage : Bool = false
    @State var shouldPopupMessage : Bool = false
    
    func createBottomToastMessage() -> some View {
        
        VStack(){
            Text("친구 추가 완료")
                .font(.custom("NotoSerifKR-Bold",size:16))
                .foregroundColor(Color("White"))
        }
        .foregroundColor(Color("White"))
        .padding(15)
        .frame(width:150)
        .background(Color("Pink"))
        .cornerRadius(15)
    }
    
    var getUser: [FriendModel] {
        Task {
            try! await firestore.searchUser(searchText)
        }
        return firestore.userList.filter {$0.nickName.localizedStandardContains(searchText)}
    }
    
    var body: some View {
        
        
        List(getUser,id:\.self) {value in
            
            
            Button {
                firestore.addFriend(friend: value)
                self.shouldBottomToastMessage = true
            } label: {
                Text(value.nickName)
            }
            
        }
        .popup(isPresented: $shouldBottomToastMessage , type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
            self.createBottomToastMessage()
        })
        
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer,
            prompt: "인간 검색"
        )
    }
}



