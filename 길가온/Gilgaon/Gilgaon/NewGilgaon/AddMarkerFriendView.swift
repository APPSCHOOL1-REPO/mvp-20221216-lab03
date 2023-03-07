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
        
        ZStack {
            
            Color("White")
            
            LazyVStack {
                ForEach(fireStoreViewModel.myFriendArray) {  friend in
                    Button {
                        fireStoreViewModel.sharedFriendList.append(FriendModel(id: friend.id, nickName: friend.nickName, userPhoto: friend.userPhoto, userEmail: friend.userEmail))
                    } label: {
                        HStack {
                            Spacer()
                            if let urlString = friend.userPhoto,
                               let imageUrl = URL(string: urlString){
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 55, height: 55)
                                        .cornerRadius(55)
                                        .overlay(RoundedRectangle(cornerRadius: 55)
                                            .stroke(Color("Pink"), lineWidth: 3))
                                } placeholder: {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 55, height: 55)
                                        .cornerRadius(55)
                                        .overlay(RoundedRectangle(cornerRadius: 55)
                                            .stroke(Color("Pink"), lineWidth: 3))
                                }
                            }else{
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 55, height: 55)
                                    .cornerRadius(55)
                                    .overlay(RoundedRectangle(cornerRadius: 55)
                                        .stroke(Color("Pink"), lineWidth: 3))
                            }
                            Spacer()
                            Text(friend.nickName)
                                .foregroundColor(Color("DarkGray"))
                                .font(.custom("NotoSerifKR-Regular",size: 16))
                            Spacer()
                        }
                    }
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
