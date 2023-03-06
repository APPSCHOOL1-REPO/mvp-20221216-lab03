//
//  RegisterModel.swift
//  Gilgaon
//
//  Created by kimminho on 2022/12/19.
//

import Foundation
import Firebase
import FirebaseAuth
import Combine
import SwiftUI
import FirebaseStorage

final class RegisterModel: ObservableObject {
    @Published var currentUser: Firebase.User?
    @Published var isError: Bool = false
    @Published var DetailError: String = ""
    @Published var userUID: String = ""
    
    init() {
        currentUser = Auth.auth().currentUser
    }

    
    var user: User? {
        didSet {
            objectWillChange.send()
        }
    }
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            self.user = user
        }
        
    }
    
    @MainActor
    // 회원가입
    func registerUser(userID: String, userPW: String, userImage: UIImage?) async{
        
        do {
            let result = try await Auth.auth().createUser(withEmail: userID, password: userPW)
            let user = result.user
            self.isError = false
            print(user.uid)
            userUID = user.uid
//            if let userImage = userImage {
//                persisImageToStorage(userImage: userImage)
//            }
        }
        
        catch {
            self.isError = true
            
            let code = (error as NSError).code
            switch code {
            case 17007:
                self.DetailError = "이미 있는 아이디"
            case 17008:
                self.DetailError = "올바름 이메일 형식이 아님"
            case 17026:
                self.DetailError = "비밀번호가 6자리 미만"
            default:
                return
            }
            
        }
    }
    
    func persisImageToStorage(userImage: UIImage) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference(withPath: uid)
        guard let imageData = userImage.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.DetailError = "Failed to push image to Storage: \(err)"
                return
            }
        }
        
        ref.downloadURL { url, err in
            if let err = err {
                self.DetailError = "Failed to retrieve downloadURL: \(err)"
                return
            }
            if let url = url{
                self.DetailError = "Successfully stored image wioth url: \(url.absoluteString ?? "")"
                print(url.absoluteString)
            }
            
        }
        
    }
    
    
    
    
    // 로그인
    func login(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.currentUser = result?.user
                
                //나중에 document 접근할 때 사용할 유저 uid
                print(self.currentUser!.uid)

        }
    }
    
    // 로그아웃
    func logout() {
        currentUser = nil
        PhotoId.photoUrl = ""
        try? Auth.auth().signOut()
        
    }
    // 회원탈퇴
    func deleteUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("User").document(uid).delete() { err in
            
            if let err {
                print("회원탈퇴 중 error 만남: \(err)")
            } else {
                let user = Auth.auth().currentUser
                user?.delete { err in
                    if let err {
                        print("사용자 삭제 중 오류 - \(err)")
                    } else {
                        print("회원탈퇴 성공")
                        self.currentUser = nil
                    }
                }
                
            }
            
        }
    }
}


//let fireStoreAddUser = FireStoreModel(id: user.uid, nickName: nickName, userPhoto: "", userEmail: userID)
//self.fireStoreViewModel.addUser(user: fireStoreAddUser)
