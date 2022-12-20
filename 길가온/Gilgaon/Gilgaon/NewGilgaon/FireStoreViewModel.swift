//
//  FireStoreViewModel.swift
//  Gilgaon
//
//  Created by kimminho on 2022/12/20.
//

import Foundation
class RollingStore: ObservableObject {
    @Published var members: [Member] = []

    
    let database = Firestore.firestore()
        
    func fetchMember(team: Team) {
        database
            .collection("rollingpaper")
            .document(team.id)
            .collection("articles")
            .getDocuments { (snapshot, error) in
                self.members.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
                        //                        print(document.documentID)
                        let id: String = document.documentID
                        
                        let docData = document.data()
                        let name: String = docData["name"] as? String ?? ""
                        let colorIndex: Int = docData["colorIndex"] as? Int ?? 0
                        let member: Member = Member(id: id, name: name, colorIndex: colorIndex)
                        
                        self.members.append(member)
                    }
                    print(self.members)
                }
            }
    }
}

