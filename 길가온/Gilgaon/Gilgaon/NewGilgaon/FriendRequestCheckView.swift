//
//  FriendRequestCheckView.swift
//  Gilgaon
//
//  Created by 김민호 on 2023/03/02.
//

//MARK: 친구요청을 확인하는 뷰
import SwiftUI

struct FriendRequestCheckView: View {
    @State private var testList: [String] = []
    var body: some View {
        if testList.isEmpty {
            VStack {
                Text("친구요청이 아직 없어요")
                Spacer()
            }
        } else {
            List {
                ForEach(testList, id:\.self) {data in
                    Text(data)
                }
            }
        }
    }
}

struct FriendRequestCheckView_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestCheckView()
    }
}
