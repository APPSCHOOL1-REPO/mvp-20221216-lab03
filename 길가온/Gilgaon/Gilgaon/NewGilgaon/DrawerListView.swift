//
//  DrawerListView.swift
//  Gilgaon
//
//  Created by zooey on 2022/12/19.
//

import SwiftUI

struct DrawerListView: View {
    var body: some View {
        ZStack {
            Color("White")
                .ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    
                }
            }
        }
    }
}

struct DrawerListView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerListView()
    }
}
