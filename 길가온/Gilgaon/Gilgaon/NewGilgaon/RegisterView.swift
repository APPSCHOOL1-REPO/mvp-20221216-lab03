//
//  HomeView.swift
//  HanselAndGretel
//
//  Created by zooey on 2022/11/29.
//

import SwiftUI

//1. Auth
//2. Storage
//3. FireStore

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var registerModel: RegisterModel
    
    @State private var nickName: String = ""
    @State private var userEmail: String = ""
    @State private var password: String = ""
    @State private var passwordCheck: String = ""
    
    @State private var errorString = ""
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                Text("닉네임")
                TextField("닉네임 입력", text: $nickName)
                Text("아이디")
                TextField("아이디 입력", text: $userEmail)
                
                //안보이는 비밀번호로 수정
                Text("비밀번호")
                SecureField("비밀번호 입력", text: $password)
                Text("비밀번호 확인")
                SecureField("비밀번호 입력", text: $passwordCheck)
            }.padding()

            Button {
                Task {
                    try! await registerModel.registerUser(userID: userEmail, userPW: password)
                    if !registerModel.isError {
                        dismiss()
                    }
                }
            } label: {
                Text("생성")
            }
            .alert("오류", isPresented: $registerModel.isError, actions: {
                
                Button("취소",role: .cancel,action: {
                })
                Button("추가", action: {
                })
            }, message: {
                Text("\(registerModel.DetailError)")
            })
            .onDisappear {
                registerModel.isError = false
            }
            

        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView().environmentObject(RegisterModel())
    }
}
