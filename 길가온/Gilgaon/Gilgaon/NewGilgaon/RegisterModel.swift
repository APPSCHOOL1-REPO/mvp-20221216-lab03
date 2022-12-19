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

final class RegisterModel: ObservableObject {
    @Published var currentUser: Firebase.User?
    @Published var isError: Bool = false
    @Published var DetailError: String = ""
    
    init() {
//        currentUser = Auth.auth().currentUser
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
    func registerUser(userID: String, userPW: String) async{
        
        do {
            let result = try await Auth.auth().createUser(withEmail: userID, password: userPW)
            let user = result.user
            self.isError = false
            print(user.uid)
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
    
    
    
    
    // 로그인
    func login(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.currentUser = result?.user
        }
    }
    
    // 로그아웃
    func logout() {
        currentUser = nil
        try? Auth.auth().signOut()
    }
}
