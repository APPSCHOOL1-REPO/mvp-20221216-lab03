//
//  AddMarkerFriendView.swift
//  Gilgaon
//
//  Created by sehooon on 2022/12/23.
//

import SwiftUI

struct AddMarkerFriendView: View {
    @ObservedObject var fireStoreViewModel: FireStoreViewModel = FireStoreViewModel()
    var body: some View {
        VStack{
            ForEach(fireStoreViewModel.myFriendArray) {  friend in
                HStack{
                    if let urlString = friend.userPhoto,
                       let imageUrl = URL(string: urlString){
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width:150)
                        } placeholder: { }
                    }else{
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width:150)
                    }
                    Text(friend.nickName)
                }
            }
        }
        .onAppear{
            fireStoreViewModel.fetchFriend()
        }
    }
}

struct AddMarkerFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddMarkerFriendView()
    }
}
