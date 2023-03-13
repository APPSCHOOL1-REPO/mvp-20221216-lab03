//
//  GuestBookView.swift
//  Gilgaon
//
//  Created by 정소희 on 2023/03/13.
//

import SwiftUI

enum AlertType {
    case delete, report
}

struct GuestBookView: View {
    
    @State private var ellipsisToggle: Bool = false // ...버튼
    @State private var deleteToggle: Bool = false // ...버튼 누르고 삭제버튼 누르면 켜지는 토글
    @State private var showingAlert = false // ...버튼 누르고 삭제 or 신고버튼 누르면 다시한번 올라오는 얼럿용 토글
    @State private var alertType = AlertType.delete
    var person: String = " "
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    VStack {
                        ForEach(1..<5) { number in
                            HStack(alignment: .top, spacing: 15) {
                                //프로필 이미지
                                if person.isEmpty {
                                    personSystemImage
                                } else {
                                    userImage
                                }
                                
                                //닉네임,글,작성시간
                                guestInfo
                                
                                Spacer()
                                
                                // ...버튼
                                Button(action: {
                                    print("눌렀습니다")
                                    ellipsisToggle.toggle()
                                }) {
                                    Image(systemName: "ellipsis")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color("Pink"))
                                        .frame(width: 20, height: 20)
                                }
                                //하단에 뜨는 얼럿
                                .confirmationDialog("해당 방명록이 불편하신가요?", isPresented: $ellipsisToggle, titleVisibility: .visible, presenting: alertType, actions: { type in
                                    Button("삭제", role: .destructive) {
                                        print("삭제하기")
                                        alertType = .delete
                                        showingAlert = true
                                        deleteToggle = true
                                    }
                                    Button("신고", role: .destructive) {
                                        print("신고하기")
                                        alertType = .report
                                        showingAlert = true
                                    }
                                    Button("취소", role: .cancel) {
                                        print("신고하기")
                                    }
                                    
                                })
                                //삭제 or 신고 버튼을 누르면 가운데에 뜨는 얼럿
                                .alert(deleteToggle ? "해당 방명록을 삭제하시겠습니까?" : "해당 방명록을 신고하시겠습니까?", isPresented: $showingAlert, presenting: alertType) { type in
                                    
                                    if type == .delete {
                                        Button("삭제", role: .destructive) {}
                                        Button("취소", role: .cancel) {}
                                    } else {
                                        Button("신고", role: .destructive) {}
                                        Button("취소", role: .cancel) {}
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            Divider()
                                .background(Color.red)
                        } //ForEach
                        
                    }
                    .padding(.vertical)
                }
            }
            
        }
    }
}

extension GuestBookView {
    
    private var personSystemImage: some View {
            Circle()
                .stroke(Color("White"), lineWidth: 1)
                .frame(width: 65, height: 65)
                .foregroundColor(Color.gray)
                .overlay {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("Pink"))
                        .frame(width: 50, height: 50)
                }
       
    }
    private var userImage: some View {
        Image("b02")
            .resizable()
            .cornerRadius(65)
            .frame(width: 65, height: 65)
    }
    
    private var guestInfo: some View {
        VStack(alignment: .leading, spacing: 9) {
            Text("닉네임")
                .font(.custom("NotoSerifKR-Bold", size: 17))
            
            Text("들어와서 반가워!들어와서 반가워!들어와서 반가워!들어와서 반가워!")
                .font(.custom("NotoSerifKR-Regular",size: 15))
            
            Text("41분 전")
                .font(.custom("NotoSerifKR-Regular",size: 13))
                .foregroundColor(Color("DarkGray"))
        }
    }
}

struct GuestBookView_Previews: PreviewProvider {
    static var previews: some View {
        GuestBookView()
    }
}
