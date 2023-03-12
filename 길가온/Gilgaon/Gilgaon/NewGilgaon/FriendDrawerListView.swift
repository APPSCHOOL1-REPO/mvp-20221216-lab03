//
//  FriendDrawerListView.swift
//  Gilgaon
//
//  Created by 전준수 on 2023/03/13.
//

import SwiftUI

struct FriendDrawerListView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("이곳에 친구의 서랍이 나올 예정입니다.")
                Text("테스트뷰입니다.")
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct FriendDrawerListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendDrawerListView()
    }
}
