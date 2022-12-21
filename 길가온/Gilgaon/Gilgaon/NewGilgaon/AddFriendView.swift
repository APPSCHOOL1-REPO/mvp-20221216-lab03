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
                            
                            VStack(alignment: .leading) {
                                Text(myFriend.nickName)
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .padding(.vertical, 10)
                            }
                            .padding(10)
                            
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 20)
                                .background(.clear)
                                .foregroundColor(.white)
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
