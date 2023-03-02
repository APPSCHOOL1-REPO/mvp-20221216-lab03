//
//  FriendRequestCheckView.swift
//  Gilgaon
//
//  Created by 김민호 on 2023/03/02.
//

//MARK: 친구요청을 확인하는 뷰
import SwiftUI
import FirebaseAuth

struct FriendRequestCheckView: View {
    @ObservedObject var friendViewModel: FriendViewModel
    @State private var testList: [String] = []
    var body: some View {
        if friendViewModel.friendRequestArrayUid.isEmpty {
            VStack {
                Text("친구요청이 아직 없어요")
                Spacer()
            }
        } else {
                List(friendViewModel.friendRequestArrayUid, id:\.self) {data in
                    HStack {
                        Text(data)
                        Spacer()
                        Button("수락") {
                            guard let myUid = Auth.auth().currentUser?.uid else { return }
                            Task {
                               await friendViewModel.findUserUId(userUid: data, myUid: myUid)
                               await friendViewModel.addFriend()
                            }
                        }
                        Button("거절") {
                            
                        }
                    }
                }
        }
    }
}

struct FriendRequestCheckView_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestCheckView(friendViewModel: FriendViewModel())
    }
}
