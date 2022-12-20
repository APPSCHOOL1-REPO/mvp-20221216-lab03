//
//  FireStoreViewModel.swift
//  Gilgaon
//
//  Created by kimminho on 2022/12/20.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FireStoreViewModel: ObservableObject {
    @Published var myFriendArray: [FriendModel] = []
    @Published var userList: [FriendModel] = []
    @Published var calendars: [CalendarStoreModel] = []
    
    let database = Firestore.firestore()
    var currentUserId:String?{ Auth.auth().currentUser?.uid }
    
    //친구목록을 조회하는 함수
    func fetchFriend(user: FireStoreModel) {
        database
            .collection("User")
            .document(user.id)
            .collection("Friend")
            .getDocuments { (snapshot, error) in
                self.myFriendArray.removeAll()
                if let snapshot {
                    for document in snapshot.documents {
                        let id: String = document.documentID
                        let docData = document.data()
                        let nickName: String = docData["nickName"] as? String ?? ""
                        let userPhoto: String = docData["userPhoto"] as? String ?? ""
                        let userEmail: String = docData["userEmail"] as? String ?? ""
                        
                        let friendInstance: FriendModel = FriendModel(id: id, nickName: nickName, userPhoto: userPhoto, userEmail: userEmail)
                        
                        self.myFriendArray.append(friendInstance)
                    }
                    print(self.myFriendArray)
                }
            }
    }
    
    //일정 추가
    func addSchedule(_ scheduleData: CalendarStoreModel){
        database
            .collection("User")
            .document(self.currentUserId!)
            .collection("Calendar")
            .document(scheduleData.id)
            .setData([
                "id": scheduleData.id,
                "title": scheduleData.title,
                "photo": scheduleData.photo,
                "createdAt": scheduleData.createdAt,
                "contents": scheduleData.contents,
                "locationName": scheduleData.locationName,
                "lat": scheduleData.lat,
                "lon": scheduleData.lon
            ])
    }
    

    //친구를 추가하는 함수
    func addFriend(user: FireStoreModel, friend: FriendModel) {
        database
            .collection("User") //
            .document(user.id)
            .collection("Friend")
            .document(friend.id)
            .setData(["id": friend.id, "nickName": friend.nickName, "userPhoto": friend.userPhoto,
                      "userEmail": friend.userEmail])
    }
    
    //유저를 추가하는 함수
    func addUser(user: FireStoreModel){
            database
                .collection("User") //
                .document(user.id)
                .setData(["id": user.id, "nickName": user.nickName, "userPhoto": user.userPhoto,
                          "userEmail": user.userEmail])
    }
    
    

    //사용자로부터 닉네임을 입력받아 일치하는 유저를 조회하는 함수
    func searchUser(_ userName: String){
            database
                .collection("User")
                .getDocuments { (snapshot, error) in
                    self.userList.removeAll()
                    if let snapshot{
                        for document in snapshot.documents{
                            let id: String = document.documentID
                            let docData = document.data()
                            if let nickName = docData["nickName"] as? String,
                               nickName == userName
                            {
                                let docData = document.data()
                                var nickName: String = docData["nickName"] as? String ?? ""
                                var userPhoto: String = docData["userPhoto"] as? String ?? ""
                                var userEmail:String = docData["userEmail"] as? String ?? ""
                                let friend = FriendModel(id: id, nickName: nickName, userPhoto: userPhoto, userEmail: userEmail)
                                self.userList.append(friend)
                            }
                        }
                    }
                }
        }

  
    func fetchCalendars() {
        database.collection("User")
            .document(self.currentUserId!)
            .collection("Calendar")
            .getDocuments { (snapshot, error) in
                self.calendars.removeAll()
                if let snapshot {
                    for document in snapshot.documents {
                        let id: String = document.documentID
                        
                        let docData = document.data()
                        
                        let title: String = docData["title"] as? String ?? ""
                        let photo: String = docData["photo"] as? String ?? ""
                        let createdAt: Double = docData["createdAt"] as? Double ?? 0
                        let contents: String = docData["contents"] as? String ?? ""
                        let locationName: String = docData["locationName"] as? String ?? ""
                        let lat: String = docData["lat"] as? String ?? ""
                        let lon: String = docData["lon"] as? String ?? ""
                        
                        
                        let calendars: CalendarStoreModel = CalendarStoreModel(id: id, title: title, photo: photo, createdAt: createdAt, contents: contents, locationName: locationName, lat: lat, lon: lon)
                        
                        self.calendars.append(calendars)
                    }
                }
            }
    }
}
