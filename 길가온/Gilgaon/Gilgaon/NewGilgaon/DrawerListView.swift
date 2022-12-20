//
//  DrawerListView.swift
//  Gilgaon
//
//  Created by zooey on 2022/12/19.
//

import SwiftUI

struct DrawerListView: View {
    @StateObject private var firestoreViewModel = FireStoreViewModel()
    
    var body: some View {
        ZStack {
            Color("White")
                .ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    ForEach(firestoreViewModel.calendars){ schedule in
                        Text(schedule.locationName)
                        Text(schedule.contents)
                    }
                }
            }
        }
        .onAppear{
            firestoreViewModel.fetchCalendars()
        }
        
        
    }
}

struct DrawerListView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerListView()
    }
}
