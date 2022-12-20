//
//  TestListView.swift
//  Gilgaon
//
//  Created by kimminho on 2022/12/20.
//

import SwiftUI

struct SearchUserView: View {
  @State private var user: [String] = ["김민호","전준수","정세훈","한주희"]
  @EnvironmentObject private var firestore: FireStoreViewModel
  @State private var searchText: String = ""
    
    var getUser: [FriendModel] {
        Task {
            try! await firestore.searchUser(searchText)
        }
        return firestore.userList.filter {$0.nickName.localizedStandardContains(searchText)}
    }
    
    var body: some View {
        
        List(getUser,id:\.self) {value in
            VStack {Text(value.nickName)}
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer,
            prompt: "인간 검색"
        )
    }
}

