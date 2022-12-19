//
//  RegisterModel.swift
//  Gilgaon
//
//  Created by kimminho on 2022/12/19.
//

import Foundation
import Firebase
import FirebaseAuth

class RegisterModel: ObservableObject {
    @Published var currentUser: Firebase.User?
    @Published var isError: Bool = false
    @Published var DetailError: String = ""
    
    init() {
//        currentUser = Auth.auth().currentUser
    }
    
    func registerUser(userID: String, userPW: String) async{
        Auth.auth().createUser(withEmail: userID, password: userPW) { result, error in
            if let error {
                self.DetailError = error.localizedDescription
                let code = (error as NSError).code
                self.isError = true
                print(code)
                switch code {
                case 17007:
                    print("이미 있는 아이디")
                case 17008:
                    print("올바름 이메일 형식이 아님")
                case 17026:
                    print("비밀번호가 6자리 미만")
                default:
                    return
                }
//                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.isError = false
            print(user.uid)
        }
    }
    
    func login(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.currentUser = result?.user
        }
    }
    func logout() {
        currentUser = nil
        try? Auth.auth().signOut()
    }
}
