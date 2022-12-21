//
//  HomeView.swift
//  HanselAndGretel
//
//  Created by zooey on 2022/11/29.
//

import SwiftUI
import Firebase
import FirebaseStorage

//1. Auth
//2. Storage
//3. FireStore

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var registerModel: RegisterModel
    @EnvironmentObject var fireStoreViewModel: FireStoreViewModel
    
    @State private var nickName: String = ""
    @State private var userEmail: String = ""
    @State private var password: String = ""
    @State private var passwordCheck: String = ""
    
    @State private var errorString = ""
    
    @State private var shouldShowImagePicker = false
    @State private var image: UIImage?
    
    var body: some View {
        
        ZStack {
            
            Color("White")
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                
                Text("회원 가입")
                    .font(.custom("NotoSerifKR-Bold", size: 30))
                    .foregroundColor(Color("DarkGray"))
                
                Button {
                    shouldShowImagePicker.toggle()
                } label: {
                    VStack {
                        if let image = self.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 128, height: 128)
                                .cornerRadius(64)
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .foregroundColor(Color("Pink"))
                                .padding()
                        }
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 64)
                    .stroke(Color("Pink"), lineWidth: 3))
                
                
                
                VStack(alignment: .leading) {
                    Text("닉네임")
                        .font(.custom("NotoSerifKR-Regular",size:16))
                        .foregroundColor(Color("DarkGray"))
                    TextField("닉네임을 입력해주세요", text: $nickName)
                        .font(.custom("NotoSerifKR-Regular",size:16))
                        .foregroundColor(Color("DarkGray"))
                    Text("이메일")
                        .font(.custom("NotoSerifKR-Regular",size:16))
                        .foregroundColor(Color("DarkGray"))
                    TextField("이메일을 입력력해주세요", text: $userEmail)
                        .font(.custom("NotoSerifKR-Regular",size:16))
                        .foregroundColor(Color("DarkGray"))
                    
                    //안보이는 비밀번호로 수정
                    Text("비밀번호")
                        .font(.custom("NotoSerifKR-Regular",size:16))
                        .foregroundColor(Color("DarkGray"))
                    SecureField("비밀번호를 입력해주세요", text: $password)
                        .font(.custom("NotoSerifKR-Regular",size:16))
                        .foregroundColor(Color("DarkGray"))
                    Text("비밀번호 확인")
                        .font(.custom("NotoSerifKR-Regular",size:16))
                        .foregroundColor(Color("DarkGray"))
                    SecureField("비밀번호를 입력해주세요", text: $passwordCheck)
                        .font(.custom("NotoSerifKR-Regular",size:16))
                        .foregroundColor(Color("DarkGray"))
                }
                .padding()
                
                Button {
                    Task {
                        try! await registerModel.registerUser(userID: userEmail, userPW: password, userImage: image)
                        try! await fireStoreViewModel.addUser(user: FireStoreModel(id: registerModel.userUID, nickName: nickName, userPhoto: "", userEmail: userEmail))
                        if !registerModel.isError {
                            dismiss()
                        }
                    }
                   
                } label: {
                    Text("가입하기")
                        .font(.custom("NotoSerifKR-Regular",size:16))
                        .foregroundColor(Color("DarkGray"))
                }
                .alert("오류", isPresented: $registerModel.isError, actions: {
                    
                    Button("취소",role: .cancel,action: {
                    })
                    Button("추가", action: {
                    })
                }, message: {
                    Text("\(registerModel.DetailError)")
                        .font(.custom("NotoSerifKR-Regular",size:16))
                })
                .onDisappear {
                    registerModel.isError = false
                }
                
            }
        }
        .fullScreenCover(isPresented: $shouldShowImagePicker) {
            ImagePicker(image: $image)
        }
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView().environmentObject(RegisterModel())
    }
}
