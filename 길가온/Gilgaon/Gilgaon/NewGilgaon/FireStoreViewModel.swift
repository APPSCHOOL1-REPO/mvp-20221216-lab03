//
//  FireStoreViewModel.swift
//  Gilgaon
//
//  Created by kimminho on 2022/12/20.

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class FireStoreViewModel: ObservableObject {
    
    @Published var users: [FireStoreModel] = []
    @Published var userList: [FriendModel] = []
    @Published var markerList: [MarkerModel] = []
    @Published var myFriendArray: [FriendModel] = []
    @Published var calendarList:[DayCalendarModel] = []
    @Published var isRecording: Bool = false
    @Published var profileUrlString: String?
    
    @Published var userNickName: String = ""
    let database = Firestore.firestore()
    var nowCalendarId: String = ""
    var currentUserId:String?{ Auth.auth().currentUser?.uid }
    
    // [Image to Storage]
    func uploadImageToStorage(userImage: UIImage, photoId: String) {
        let ref = Storage.storage().reference(withPath: photoId)
        guard let imageData = userImage.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err { return }
        }
        ref.downloadURL { url, err in
            if let err = err { return }
            print(url?.absoluteString)
        }
    }
    
    // [fetch Profile Image]
    func fetchImageUrl() {
        let storage = Storage.storage()
        guard let uid = Auth.auth().currentUser?.uid else{return}
        let pathReference = storage.reference(withPath: uid)
        pathReference.downloadURL { url, error in
            if let error = error {
                print(error)
            } else {
                guard let urlString = url?.absoluteString else {
                    return
                }
                self.profileUrlString = urlString
            }
        }
    }
    
    //
    func addLocationImage(){
        
    }
    
    //친구목록을 조회하는 함수
    func fetchFriend() {
        database
            .collection("User")
            .document(self.currentUserId!)
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
    func addSchedule(_ scheduleData: MarkerModel){
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
        self.nowCalendarId = scheduleData.id
    }
    
    
    //친구를 추가하는 함수
    func addFriend(friend: FriendModel) {
        database
            .collection("User") //
            .document(self.currentUserId!)
            .collection("Friend")
            .document(friend.id)
            .setData(["id": friend.id, "nickName": friend.nickName, "userPhoto": friend.userPhoto,
                      "userEmail": friend.userEmail])
    }
    
    // 친구를 삭제하는 함수
    func deleteFriend(friend: FriendModel) {
        database
            .collection("User")
            .document(self.currentUserId!)
            .collection("Friend")
            .document(friend.id)
            .delete()
        fetchFriend()
    }
    
    
    
    //사용자의 로그인 정보를 추가하는 함수
    func addUser(user: FireStoreModel){
        database
            .collection("User") //
            .document(user.id)
            .setData(["id": user.id, "nickName": user.nickName, "userPhoto": user.userPhoto,
                      "userEmail": user.userEmail])
    }
    
    //사용자로부터 닉네임을 입력받아 일치하는 유저를 조회하는 함수
    func myInfo(_ userID: String){
        database
            .collection("User")
            .getDocuments { (snapshot, error) in
                self.userList.removeAll()
                if let snapshot{
                    for document in snapshot.documents{
                        let id: String = document.documentID
                        let docData = document.data()
                        if id == userID {
                            let docData = document.data()
                            let nickName: String = docData["nickName"] as? String ?? ""
                            let userPhoto: String = docData["userPhoto"] as? String ?? ""
                            let userEmail:String = docData["userEmail"] as? String ?? ""
                            let friend = FriendModel(id: id, nickName: nickName, userPhoto: userPhoto, userEmail: userEmail)
                            self.userNickName = friend.nickName
                        }
                    }
                }
            }
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
                           nickName.contains(userName)
                        {
                            let docData = document.data()
                            let nickName: String = docData["nickName"] as? String ?? ""
                            let userPhoto: String = docData["userPhoto"] as? String ?? ""
                            let userEmail:String = docData["userEmail"] as? String ?? ""
                            let friend = FriendModel(id: id, nickName: nickName, userPhoto: userPhoto, userEmail: userEmail)
                            self.userList.append(friend)
                        }
                    }
                }
            }
    }
    
    
    // [서랍 doc생성]
    func addCalendar(_ calendar: DayCalendarModel){
        database
            .collection("User")
            .document(self.currentUserId!)
            .collection("Calendar")
            .document(calendar.id)
            .setData([
                "id": calendar.id,
                "createdAt": calendar.createdAt,
                "title": calendar.title,
                "shareFriend": calendar.shareFriend,
                "realDate": calendar.realDate
            ])
        
        self.nowCalendarId = calendar.id
        print("nowCalendarId: \(self.nowCalendarId)")
        calendarList.append(calendar)
    }
    
    
    //[서랍 data불러오기]
    func fetchDayCalendar(){
        database
            .collection("User")
            .document(self.currentUserId!)
            .collection("Calendar")
            .getDocuments { (snapshot, error) in
                self.calendarList.removeAll()
                if let snapshot{
                    for document in snapshot.documents{
                        let id = document.documentID
                        let docData = document.data()
                        let createdAt = docData["createdAt"] as? [String] ?? []
                        let title = docData["title"] as? String ?? ""
                        let shareFriend = docData["shareFriend"] as? [String] ?? []
                        let taskDate = docData["taskDate"] as? Date ?? Date()
                        let realDate = docData["realDate"] as? Double ?? 0.0
                        print("realDate: \(realDate)")
                        let calendarData = DayCalendarModel(id: id, createdAt: createdAt, title: title, shareFriend: shareFriend, taskDate: taskDate, realDate: realDate)
                        print(calendarData)
                        self.calendarList.append(calendarData)
                    }
                }
            }
    }
    
    // [마커 생성하기]
    func addMarker(_ marker: MarkerModel){
        database
            .collection("User")
            .document(self.currentUserId!)
            .collection("Calendar")
            .document(self.nowCalendarId) //출력됨
            .collection("Marker")
            .document(marker.id)
            .setData([
                "id": marker.id,
                "title": marker.title,
                "photo": marker.photo,
                "createdAt": marker.createdAt,
                "contents": marker.contents,
                "locationName": marker.locationName,
                "lat": marker.lat,
                "lon": marker.lon
            ])
        fetchMarkers()
    }
    
    
    // [마커 가져오기]
    func fetchMarkers() {
        database.collection("User")
            .document(self.currentUserId!)
            .collection("Calendar")
            .document(self.nowCalendarId)
            .collection("Marker")
            .getDocuments { (snapshot, error) in
                self.markerList.removeAll()
                LocationsDataService.locations.removeAll()
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
                        
                        let marker: MarkerModel = MarkerModel(id: id, title: title, photo: photo, createdAt: createdAt, contents: contents, locationName: locationName, lat: lat, lon: lon)
                        
                        self.markerList.append(marker)
                        LocationsDataService.locations = self.markerList
                    }
                }
            }
    }
}
