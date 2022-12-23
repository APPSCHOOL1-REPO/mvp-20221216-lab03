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
        
        ZStack {
            Color("White")
                .ignoresSafeArea()
            List {
                ForEach(getUser,id:\.self) {value in
                    
                    HStack(alignment: .center) {
                        if let url = value.userPhoto,
                           let imageUrl = URL(string: url) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 110, height: 110)
                                    .cornerRadius(20)
                                    .overlay(RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color("Pink"), lineWidth: 3))
                            } placeholder: {
                                
                            }
                        } else{
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("Pink"))
                                .font(.system(size: 20))
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color("Pink"), lineWidth: 3))
                        }
                        
                        Button {
                            firestore.addFriend(friend: value)
                            self.shouldBottomToastMessage = true
                        } label: {
                            Text(value.nickName)
                                .foregroundColor(Color("DarkGray"))
                                .font(.custom("NotoSerifKR-Regular",size:16))
                                .bold()
                        }
                    }
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 20)
                        .background(.clear)
                        .foregroundColor(Color("White"))
                        .padding(
                            EdgeInsets(
                                top: 10,
                                leading: 10,
                                bottom: 10,
                                trailing: 10
                            )
                        )
                )
                .listRowSeparator(.hidden)
                
            }
            .scrollContentBackground(.hidden)
            .background(Color("White"))
            .popup(isPresented: $shouldBottomToastMessage , type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
                self.createBottomToastMessage()
            })
            
            
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer,
            prompt: Text("친구 검색")
        )
        .font(.custom("NotoSerifKR-Regular",size:16))
        .bold()
    }
    
}



