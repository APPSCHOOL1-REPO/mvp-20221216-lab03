//
//  FireStoreModel.swift
//  Gilgaon
//
//  Created by kimminho on 2022/12/20.
//

import Foundation


// Collection User
struct FireStoreModel: Identifiable {
    var id: String //currentUser UID (Document ID)
    
    // field 값들
    var nickName: String
    var userPhoto: String
    var userEmail: String
    //
}

struct CalendarModelModel: Identifiable {
    
    var id: String
    var title: String
    var photo: String
    var createdAt: Double
    var contents: String
    var locationName: String
    var lat: String
    var lon: String
}

struct FriendModel: Identifiable {
    var id: String //currentUser UID (Document ID)
    // field 값들
    var nickName: String
    var userPhoto: String
    var userEmail: String
}




