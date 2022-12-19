//
//  CalendarSelectView.swift
//  Gilgaon
//
//  Created by kimminho on 2022/11/29.
//

import SwiftUI


//MARK: - 달력의 요일을 클릭했을 때 보여줄 뷰 입니다.
struct CalendarSelectView: View {
    @State private var friendArray: [String] = []
    @State private var emoji: [String] = ["😆","😏","🥹"]
    @State private var showInSheet: Bool = false
    
    
    func friendCircle() -> some View {
        ZStack {
            Circle()
                .foregroundColor(.gray)
                .frame(width: 100,height: 100)
            Image(systemName: "plus")
                .overlay(Circle().stroke(.black,lineWidth: 0.5))
                .offset(x:33,y:30)
        }

            
    }
    
    
    var body: some View {
        
        ZStack {
            
            Color("White")
                .ignoresSafeArea()
            
            VStack {
                Text("00월 00 일의 일정을 시작합니다")
                    .foregroundColor(Color("DarkGray"))
                HStack {
                    Text("함께하는 친구")
                        .foregroundColor(Color("DarkGray"))
                    Button {
                        
                        showInSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color("Red"))
                    }
                    .sheet(isPresented: $showInSheet) {
                        InviteFriendView()
                            .presentationDetents([.medium,.large]) //미디엄까지 modal 올라옴
                    }
                }
                
                friendCircle()
                
                HStack {
                    Image(systemName: "cloud")
                    Image(systemName: "cloud")
                    Image(systemName: "cloud")
                }
                .foregroundColor(Color("DarkGray"))
            }
        }
    }
}

struct CalendarSelectView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarSelectView()
    }
}
