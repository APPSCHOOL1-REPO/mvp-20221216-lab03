//
//  CalendarView.swift
//  HanselAndGretel
//
//  Created by zooey on 2022/11/29.
//

import SwiftUI

struct CalendarView: View {
    
    @State var currentDate: Date = Date()
    @State var calID: [String] = []
    @State var isTapped: Bool = true

    var body: some View {
        
        
        ZStack {
            Color("White")
                .ignoresSafeArea()

//            ScrollView(.vertical, showsIndicators: false) {

                VStack(spacing: 20) {
                    CustomDataPicker(currentDate: $currentDate, calID: $calID)

                }
                .padding(.vertical)
//            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}



