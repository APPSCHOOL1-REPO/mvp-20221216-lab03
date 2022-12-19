//
//  ShareLinkView.swift
//  ShrareLinkPhotos
//
//  Created by Jongwook Park on 2022/11/16.
//

import SwiftUI

struct SharingPhoto: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }

    public var image: Image
    public var caption: String
}


struct InviteFriendView: View {
    private let url = URL(string: "https://likelion.net")!
    
    private let photo = SharingPhoto(image: Image(systemName: "flame"), caption: "This is a flame!")
    
    var body: some View {
 
        ZStack {
            Color("White")
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                LottieView2(filename: "InviteFriendLottie")
                    .ignoresSafeArea()
                    .offset(x:-109,y:64)
                    .frame(width: 100,height: 100)
                    .opacity(0.6)
                Text("친구와 함께")
                    .font(.custom("NotoSerifKR-Bold",size:35))
                    .foregroundColor(Color("Pink"))
                Text("일정을 공유하세요")
                    .font(.custom("NotoSerifKR-Bold",size:35))
                    .foregroundColor(Color("Pink"))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 300, trailing: 0))
                
                
                ShareLink(item: photo,
                          subject: Text("Flame Photo"),
                          message: Text("Check it out!"),
                          preview: SharePreview(photo.caption, image: photo.image)) {
                    Text("초대하기")
                        .font(.custom("NotoSerifKR-SemiBold",size:25))
                        .foregroundColor(Color("DarkGray"))
                }
                .font(.largeTitle)
                
            }
        }
    }
}

struct InviteFriendView_Previews: PreviewProvider {
    static var previews: some View {
        InviteFriendView()
    }
}
