////
////  AuthAppDelegate.swift
////  HanselAndGretel
////
////  Created by 서광현 on 2022/11/29.
////
//
//import Foundation
//import UIKit
//
///// KAKAO
//import KakaoSDKCommon
//import KakaoSDKAuth
//
//
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        
//        // MARK: - KAKAO
//        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
//        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
//        return true
//    }
//    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        // MARK: - KAKAO
//        if (AuthApi.isKakaoTalkLoginUrl(url)) {
//            return AuthController.handleOpenUrl(url: url)
//        }
//        return false
//    }
//    
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
//        
//        sceneConfiguration.delegateClass = SceneDelegate.self
//        return sceneConfiguration
//    }
//}
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        if let url = URLContexts.first?.url {
//            if (AuthApi.isKakaoTalkLoginUrl(url)) {
//                _ = AuthController.handleOpenUrl(url: url)
//            }
//        }
//    }
//}
//
