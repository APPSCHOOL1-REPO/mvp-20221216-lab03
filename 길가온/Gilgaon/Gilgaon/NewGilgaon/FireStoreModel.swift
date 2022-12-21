//
//  FireStoreModel.swift
//  Gilgaon
//
//  Created by kimminho on 2022/12/20.
//

import Foundation

// Collection User
struct FireStoreModel: Codable,Identifiable,Hashable {
    var id: String //currentUser UID (Document ID)
    
    // field 값들
    var nickName: String
    var userPhoto: String
    var userEmail: String
    //
}

// [기록시작 -> 생성]
struct DayCalendarModel: Identifiable{
    var id: String
    var taskDate: Date
    var createdAt: [String]
    // 제목 : [서울여행]
    var title: String
    // 추후
    var shareFriend:[String]
}

// [마커 Data]
struct MarkerModel: Identifiable {
    var id: String
    var title: String
    var photo: String
    var createdAt: Double
    var contents: String
    var locationName: String
    var lat: String
    var lon: String
    
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_Kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateCreatedAt = Date(timeIntervalSince1970: createdAt)
        
        return dateFormatter.string(from: dateCreatedAt)
    }
}



struct FriendModel: Codable,Identifiable,Hashable {
    var id: String //currentUser UID (Document ID)
    // field 값들
    var nickName: String
    var userPhoto: String
    var userEmail: String
}




