//
//  AddFriendView.swift
//  Gilgaon
//
//  Created by kimminho on 2022/12/20.
//

import SwiftUI

struct AddFriendView: View {
    @StateObject private var fireStoreViewModel: FireStoreViewModel = FireStoreViewModel()
    
    var body: some View {
  
            ZStack {
                
                
                List {
           
                        ForEach(fireStoreViewModel.myFriendArray, id: \.self) { myFriend in
                            
                            HStack(alignment: .center) {
                                Circle()
                                    .frame(width: 100, height: 100)
                                
                                VStack {
                                    Text(myFriend.nickName)
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .padding(.vertical, 10)
                                }
                            }
                            .padding(10)
                            
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
                .background(.green)

                
        }
            .onAppear {
                fireStoreViewModel.fetchFriend()
            }
    }
}

//struct AddFriendView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddFriendView()
//    }
//}
