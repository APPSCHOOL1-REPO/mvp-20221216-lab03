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
    @ObservedObject var firestore: FireStoreViewModel
    @State private var searchText: String = ""
    @State var shouldBottomToastMessage : Bool = false
    @State var shouldPopupMessage : Bool = false
    @ObservedObject var friendViewModel: FriendViewModel
    
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
    
    var body: some View {
        
        ZStack {
            Color("White")
                .ignoresSafeArea()
            VStack {
                HStack {
                    TextField("친구 검색",text: $firestore.searchText)
                        .padding(.horizontal, 40)
                        .frame(width: UIScreen.main.bounds.width - 110, height: 45, alignment: .leading)
                        .background(Color(#colorLiteral(red: 0.9294475317, green: 0.9239223003, blue: 0.9336946607, alpha: 1)))
                        .clipped()
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 16)
                            }
                        )
                    Spacer()
                }
                List(firestore.userList, id:\.self) { user in
                    HStack {
                        Text(user.nickName)
                        Spacer()
                        if !firestore.myFriendArray.contains(user) {
                            Button {
                                Task {
                                    //친구요청을 보냄
                                    await friendViewModel.sendFriendRequest(friendUid: user.id)
                                }
                            } label: {
                                Text("추가하기")
                            }
                        }

                    }
                }
//                List {
//                    ForEach(firestore.userList,id:\.self) {value in
//
//                        HStack(alignment: .center) {
//                            if let url = value.userPhoto,
//                               let imageUrl = URL(string: url) {
//                                AsyncImage(url: imageUrl) { image in
//                                    image
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 55, height: 55)
//                                        .cornerRadius(28)
//                                        .overlay(RoundedRectangle(cornerRadius: 30)
//                                            .stroke(Color("Pink"), lineWidth: 3))
//                                } placeholder: {
//
//                                }
//                            } else{
//                                Image(systemName: "person.fill")
//                                    .foregroundColor(Color("Pink"))
//                                    .font(.system(size: 20))
//                                    .padding()
//                                    .overlay(RoundedRectangle(cornerRadius: 30)
//                                        .stroke(Color("Pink"), lineWidth: 3))
//                            }
//
//                            Button {
//                                firestore.addFriend(friend: value)
//                                self.shouldBottomToastMessage = true
//                            } label: {
//                                Text(value.nickName)
//                                    .foregroundColor(Color("DarkGray"))
//                                    .font(.custom("NotoSerifKR-Regular",size:16))
//                                    .bold()
//                            }
//                        }
//                        .onAppear{
//                            firestore.fetchImageUrl()
//                        }
//
//                    }
//                    .listRowBackground(
//                        RoundedRectangle(cornerRadius: 20)
//                            .background(.clear)
//                            .foregroundColor(Color("White"))
//                            .padding(
//                                EdgeInsets(
//                                    top: 10,
//                                    leading: 10,
//                                    bottom: 10,
//                                    trailing: 10
//                                )
//                            )
//                    )
//                    .listRowSeparator(.hidden)
//
//                }
            }
            .onAppear {
                firestore.searchUser()
            }
            .scrollContentBackground(.hidden)
            .background(Color("White"))
            .popup(isPresented: $shouldBottomToastMessage , type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
                self.createBottomToastMessage()
            })
        }
        .font(.custom("NotoSerifKR-Regular",size:16))
        .bold()
    }
    
}


struct SearchUserView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserView(firestore: FireStoreViewModel(), friendViewModel: FriendViewModel())
    }
}
