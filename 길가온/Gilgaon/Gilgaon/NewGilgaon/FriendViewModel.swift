//
//  FriendViewModel.swift
//  Gilgaon
//
//  Created by 김민호 on 2023/03/02.
//

import Foundation
import Firebase
import FirebaseAuth

class FriendViewModel: ObservableObject {
    @Published var myInfo: FriendModel?
    @Published var friendInfo: FriendModel?
    @Published var friendRequestArray: [FriendModel] = []
    @Published var friendRequestArrayUid: [String] = []
    @Published var listener: ListenerRegistration?
    @Published var myFriendFriendArray: [FriendModel] = []
    let database = Firestore.firestore()
    //상대방이 추가할 때 내 아이디에 친구의 uid를 담아준다.
    
    //나의 친구요청목록을 확인할 때
    func fetchFriendRequest(){
        print(#function)
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = database.collection("Waiting").document(uid)
        listener = ref.addSnapshotListener { querySnapshot, error in
            guard let document = querySnapshot  else { return }
            guard let docData = document.data() else { return }
            self.friendRequestArrayUid = docData["sendToFriend"] as? [String] ?? []
        }
    }
    
    
    //[sendFriendRequest를 위한 함수] 친구에게 온 친구목록을 조회
    private func fetchWaitingFriend(_ userId: String) async -> [String]? {
        print(#function)
        do{
            let document = try await database.collection("Waiting").document(userId).getDocument()
            guard let docData = document.data() else{ return [] }
            let waitingArr = docData["sendToFriend"] as? [String] ?? []
            return waitingArr
        }catch{
            print("Error!")
            return nil
        }
    }
    //친구요청을 보낼 때
    func sendFriendRequest(friendUid: String) async {
        print(#function)
        guard let myUid = Auth.auth().currentUser?.uid else { return }
        guard var friendsWaitingArray = await self.fetchWaitingFriend(friendUid) else {return}
        friendsWaitingArray.append(myUid)
        print("없니..?",friendsWaitingArray)
        //친구의 uid에 내 uid를 추가함
        do {
            print("do문 입니다.")
            try await database
                .collection("Waiting")
                .document(friendUid)
                .setData(["sendToFriend": friendsWaitingArray])
        } catch {
            print("== sendFriendRequest error ==")
        }
    }
    //친구를 추가할 때
    func addFriendBoth() {
        
    }
    func deleteWaitingFriend(userId: String) async {
        print(#function)
        guard let myId = Auth.auth().currentUser?.uid else { return }
        guard var waitingFriend = await fetchWaitingFriend(myId) else { return }
        guard let index = waitingFriend.firstIndex(of: userId) else { return }
        waitingFriend.remove(at: index)
        do{
            try await database.collection("Waiting").document(myId).updateData([ "sendToFriend" : waitingFriend ])
        }catch{
                print("Error")
        }
    }
    
    //친구추가
    func addFriendMe() async throws{
        try await database
            .collection("User") //
            .document(myInfo!.id)
            .collection("Friend")
            .document(friendInfo!.id)
            .setData(["id": friendInfo!.id,
                      "nickName": friendInfo!.nickName,
                      "userPhoto": friendInfo!.userPhoto,
                      "userEmail": friendInfo!.userEmail])
    }
    
    func addFriend() async throws{
        try await database
            .collection("User") //
            .document(friendInfo!.id)
            .collection("Friend")
            .document(myInfo!.id)
            .setData(["id": myInfo!.id,
                      "nickName": myInfo!.nickName,
                      "userPhoto": myInfo!.userPhoto,
                      "userEmail": myInfo!.userEmail])
    }
    
    //사용자로부터 닉네임을 입력받아 일치하는 유저를 조회하는 함수
    func findUserUIdMe(userUid: String) async{
        database
            .collection("User")
            .getDocuments { (snapshot, error) in
//                self.userList.removeAll()
                if let snapshot{
                    for document in snapshot.documents{
                        let id: String = document.documentID
                        if id == userUid {
                            let docData = document.data()
                            let nickName: String = docData["nickName"] as? String ?? ""
                            let userPhoto: String = docData["userPhoto"] as? String ?? ""
                            let userEmail:String = docData["userEmail"] as? String ?? ""
                            let friend = FriendModel(id: id, nickName: nickName, userPhoto: userPhoto, userEmail: userEmail)
                            self.myInfo = friend
                            print(self.myInfo)
                        }
                    }
                }
            }
    }
    
    func findUserFriend(userUid: String) async{
        database
            .collection("User")
            .getDocuments { (snapshot, error) in
//                self.userList.removeAll()
                if let snapshot{
                    for document in snapshot.documents{
                        let id: String = document.documentID
                        if id == userUid {
                            let docData = document.data()
                            let nickName: String = docData["nickName"] as? String ?? ""
                            let userPhoto: String = docData["userPhoto"] as? String ?? ""
                            let userEmail:String = docData["userEmail"] as? String ?? ""
                            let friend = FriendModel(id: id, nickName: nickName, userPhoto: userPhoto, userEmail: userEmail)
                            self.friendInfo = friend
                        }
                    }
                }
            }
    }
    
    //친구의 친구목록을 조회하는 함수
    func fetchFriendFriend(userUid: String) async{
        await database
            .collection("User")
            .document(userUid)
            .collection("Friend")
            .getDocuments { (snapshot, error) in
                self.myFriendFriendArray.removeAll()
                if let snapshot {
                    for document in snapshot.documents {
                        let id: String = document.documentID
                        let docData = document.data()
                        let nickName: String = docData["nickName"] as? String ?? ""
                        let userPhoto: String = docData["userPhoto"] as? String ?? ""
                        let userEmail: String = docData["userEmail"] as? String ?? ""
                        
                        let friendInstance: FriendModel = FriendModel(id: id, nickName: nickName, userPhoto: userPhoto, userEmail: userEmail)
                        
                        self.myFriendFriendArray.append(friendInstance)
                    }
                    print("니친구들 다보여줘바")
                    print(self.myFriendFriendArray)
                }
            }
    }
    
}
