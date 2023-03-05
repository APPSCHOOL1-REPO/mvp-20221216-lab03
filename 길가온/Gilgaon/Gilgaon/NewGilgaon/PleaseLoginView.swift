//
//  PleaseLoginView.swift
//  Gilgaon
//
//  Created by 전준수 on 2022/12/19.
//

import SwiftUI

struct PleaseLoginView: View {
    @EnvironmentObject var registerModel: RegisterModel
    var body: some View {
        
        NavigationStack {
            Group {
                if registerModel.currentUser != nil {
                    if registerModel.currentUserProfile == nil {
                        RegisterView()
                    } else {
                        HomeView()
                    }
                } else {
                    LoginView()
                }
            }
            .onAppear {
                registerModel.listenToAuthState()
                if registerModel.currentUser != nil {
                    Task{
                        registerModel.currentUserProfile = try await registerModel.fetchUserInfo(_: registerModel.currentUser!.uid)
                    }
                }
            }
        }
        .accentColor(Color("Red"))
    }
}

struct PleaseLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PleaseLoginView().environmentObject(RegisterModel())
    }
}

extension UINavigationController {

  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    navigationBar.topItem?.backButtonDisplayMode = .minimal
  }

}
