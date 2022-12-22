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
    
    enum Field {
        case nickName
        case email
        case password
        case passwordCheck
    }
    @FocusState private var focusField: Field?
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var registerModel: RegisterModel
    @EnvironmentObject var fireStoreViewModel: FireStoreViewModel
    
    @State private var nickName: String = ""
    @State private var userEmail: String = ""
    @State private var password: String = ""
    @State private var passwordCheck: String = ""
    
    @State private var checkEmail: Bool = true
    @State private var checkPassword: Bool = true
//    @State private var checkEmail: Bool = true
    @State private var errorString = ""
    
    @State private var shouldShowImagePicker = false
    @State private var image: UIImage?
    func SectionLabel(labelName: String) -> some View {
        Text(labelName)
            .font(.custom("NotoSerifKR-Regular",size:14))
            .foregroundColor(Color("DarkGray"))
    }
    
    func isValidEmail(inputYourEmail: String) -> Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
          let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailTest.evaluate(with: inputYourEmail)
    }
    func checkPasswordLogic(password: String, checkPassword: String) -> Bool {
        return ((password.count >= 6) && (checkPassword.count >= 6)) && (password == checkPassword)
            
        
    }
    
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
                Text("프로필 사진을 추가해보세요")
                    .font(.custom("NotoSerifKR-Regular",size:14))
                    .foregroundColor(Color("DarkGray"))
                

                
                Form {
                    Section {
                        HStack {
                            TextField("닉네임을 입력해주세요", text: $nickName)
                                .focused($focusField, equals: .nickName)
                            Circle()
                                .frame(width:10,height:10)
                                .foregroundColor((nickName.count >= 2) && nickName.count <= 15 ? .green : .red)
                        }

                    } header: {
                        SectionLabel(labelName: "닉네임")
                    }.onSubmit {
                        focusField = .email
                    }
                    
                    Section {
                        HStack {
                            TextField("이메일을 입력해주세요.", text: $userEmail)
                                .focused($focusField, equals: .email)
                            Circle()
                                .frame(width:10,height:10)
                                .foregroundColor(isValidEmail(inputYourEmail: userEmail) ? .green : .red)
                        }
                        
                    } header: {
                        SectionLabel(labelName: "이메일")
                    }
                    .onSubmit {
                        focusField = .password
                    }
                    
                    Section {
                        HStack {
                            SecureField("비밀번호 입력", text: $password)
                                .focused($focusField, equals: .password)
                            Circle()
                                .frame(width:10,height:10)
                                .foregroundColor(password.count >= 6 ? .green : .red)
                        }
                        .onSubmit {
                                focusField = .passwordCheck
                        }
                        HStack {
                            SecureField("비밀번호를 재입력", text: $passwordCheck)
                                .focused($focusField, equals: .passwordCheck)
                            Circle()
                                .frame(width:10,height:10)
                                .foregroundColor(checkPasswordLogic(password: password, checkPassword: passwordCheck) ? .green : .red)
                        }
                    } header: {
                        SectionLabel(labelName: "비밀번호")
                    }

                }
                .textInputAutocapitalization(.never)
                .scrollContentBackground(.hidden)
                .font(.custom("NotoSerifKR-Regular",size:13))
                .foregroundColor(Color("DarkGray"))

                
                Button {
                    if (nickName != "") && (userEmail != "") && (password != "" && password.count >= 6) && (passwordCheck != "" && passwordCheck.count >= 6) {
                        Task {
                            try! await registerModel.registerUser(userID: userEmail, userPW: password, userImage: image)
                            if registerModel.userUID != "" {
                                try! await fireStoreViewModel.addUser(user: FireStoreModel(id: registerModel.userUID, nickName: nickName, userPhoto: "", userEmail: userEmail))
                            }
                            if !registerModel.isError {
                                dismiss()
                            }
                        }
                    }else {
                        print("문제있음")
                    }
                   
                } label: {
                    Text("가입하기")
                        .font(.custom("NotoSerifKR-Bold",size:18))
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
                Spacer()
                
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
