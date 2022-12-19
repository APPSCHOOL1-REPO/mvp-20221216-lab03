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

class RegisterModel: ObservableObject {
    @Published var currentUser: Firebase.User?
    @Published var isError: Bool = false
    @Published var DetailError: String = ""
    
    init() {
//        currentUser = Auth.auth().currentUser
    }

    @MainActor
    func registerUser1(userID: String, userPW: String) async{
        
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
                print("올바름 이메일 형식이 아님")
            case 17026:
                print("비밀번호가 6자리 미만")
            default:
                return
            }
            self.DetailError = error.localizedDescription
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
