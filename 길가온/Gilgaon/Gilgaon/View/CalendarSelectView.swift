//
//  CalendarSelectView.swift
//  Gilgaon
//
//  Created by kimminho on 2022/11/29.
//

import SwiftUI


//MARK: - μμ°λλ·°
struct CalendarSelectView: View {
    @State private var friendArray: [String] = []
    @State private var emoji: [String] = ["π","π","π₯Ή"]
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
                Text("00μ 00 μΌμ μΌμ μ μμν©λλ€")
                    .foregroundColor(Color("DarkGray"))
                HStack {
                    Text("ν¨κ»νλ μΉκ΅¬")
                        .foregroundColor(Color("DarkGray"))
                    Button {
                        
                        showInSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color("Red"))
                    }
                    .sheet(isPresented: $showInSheet) {
                        InviteFriendView()
                            .presentationDetents([.medium,.large]) //λ―ΈλμκΉμ§ modal μ¬λΌμ΄
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
