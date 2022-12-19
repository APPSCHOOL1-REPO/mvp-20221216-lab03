//
//  LoginView.swift
//  HanselAndGretel
//
//  Created by zooey on 2022/11/29.
//

import SwiftUI
import AuthenticationServices

struct AppleUser: Codable {
    let userId: String
    let firstName: String
    let lastName: String
    let email: String
    
    init?(credentials: ASAuthorizationAppleIDCredential) {
        guard
            let firstName = credentials.fullName?.givenName,
            let lastName = credentials.fullName?.familyName,
            let email = credentials.email
        else { return nil }
        
        self.userId = credentials.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}

struct LoginView: View {
    @StateObject var kakaoLoginViewModel: KakaoAuthViewModel = KakaoAuthViewModel()
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                Color("White")
                    .ignoresSafeArea()
                
                LottieView2(filename: "Sakura")
                    .ignoresSafeArea()
                    .offset(x:200,y:-270)
                    .frame(width: 2000,height: 1300)
                    .opacity(0.6)
           
                    MyPath2()
                        .stroke(Color("Pink"))
                        .offset(x: 800, y: 280)
      
                VStack {
                    
                    VStack(spacing: 27) {
                        
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(Color("DarkGray"))
                            TextField("이메일", text: $email)
                                .font(.custom("NotoSerifKR-Regular",size:16))
                        }
                        .padding()
                        .padding(.leading, 8)
                        .offset(x: 800, y: 13)
                        
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(Color("DarkGray"))
                            TextField("비밀번호", text: $password)
                        }
                        .font(.custom("NotoSerifKR-Regular",size:16))
                        .padding()
                        .padding(.leading, 8)
                        .offset(x: 800, y: 13)
                        
                        
                        NavigationLink {
                            HomeView()
                        } label: {
                            
                            Text("로그인")
                                .foregroundColor(Color("DarkGray"))
                                .font(.custom("NotoSerifKR-Bold",size:20))
                                .bold()
                        }
                        
                        
                        Text("OR")
                            .foregroundColor(Color("DarkGray"))
                            .font(.custom("NotoSerifKR-Medium",size:16))
                        
                    }
                    
                    
                    HStack(spacing: 20) {
                        // 애플 버튼
                        CustomButton()
                            .foregroundColor(.white)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.black)
                            }
                            .overlay {
                                SignInWithAppleButton(.signIn, onRequest: configure, onCompletion: handle)
                                    .blendMode(.overlay)
                            }
                            .clipped()
                        
                        CustomButton(isKakao: true)
                            .foregroundColor(.black)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.yellow)
                            }
                            .overlay{
                                Button {
                                    kakaoLoginViewModel.handleKakaoLogin()
                                } label: {
                                    Text("카카오 로그인")
                                }
                                .blendMode(.overlay)
                                
                            }
                            .clipped()
                        
                    }
                
                    
                }
               
            }
            .navigationBarHidden(true)
        }
        .accentColor(Color("Red"))
    }
    
    func configure(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
//        request.nonce = ""
    }
    
    func handle(_ authResult: Result<ASAuthorization, Error>) {
        switch authResult {
        case .success(let auth):
            print(auth)
            switch auth.credential {
            case let appleIdCredentials as ASAuthorizationAppleIDCredential:
                if let appleUser = AppleUser(credentials: appleIdCredentials),
                   let appleUserData = try? JSONEncoder().encode(appleUser) {
                    UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userId)
                    
                    print("saved apple user", appleUser)
                } else {
//                    print("missing some fields", appleIdCredentials.email, appleIdCredentials.fullName, appleIdCredentials.user)
                    
                    guard
                        let appleUserData = UserDefaults.standard.data(forKey: appleIdCredentials.user),
                        let appleUser = try? JSONDecoder().decode(AppleUser.self, from: appleUserData)
                    else { return }
                    
                    print(appleUser)
                }
                
            default:
                print(auth.credential)
            }
            
        case .failure(let error):
            print(error)
        }
    }
    
    @ViewBuilder
    func CustomButton(isKakao: Bool = false)->some View {
        HStack{
            Group{
                if isKakao{
                    Image("Kakao")
                        .resizable()

                }else{
                    Image(systemName: "applelogo")
                        .resizable()
                    
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .frame(height: 45)
            
            Text("\(isKakao ? "카카오 로그인" : "Apple Sign in")")
                .font(.callout)
                .lineLimit(1)
        }
        .padding(.horizontal,15)
        
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct MyPath2: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.move(to: CGPoint(x: 50, y: 320))
        path.addLine(to: CGPoint(x: 340, y: 320))
        
        path.move(to: CGPoint(x: 50, y: 323))
        path.addLine(to: CGPoint(x: 340, y: 323))
        
        path.move(to: CGPoint(x: 50, y: 360))
        path.addLine(to: CGPoint(x: 340, y: 360))
        
        path.move(to: CGPoint(x: 50, y: 363))
        path.addLine(to: CGPoint(x: 340, y: 363))
        
        path.move(to: CGPoint(x: 50, y: 280))
        path.addLine(to: CGPoint(x: 340, y: 280))
        
        path.move(to: CGPoint(x: 50, y: 283))
        path.addLine(to: CGPoint(x: 340, y: 283))
        
        path.move(to: CGPoint(x: 50, y: 240))
        path.addLine(to: CGPoint(x: 340, y: 240))
        
        path.move(to: CGPoint(x: 50, y: 243))
        path.addLine(to: CGPoint(x: 340, y: 243))
        
        return path
    }
}
