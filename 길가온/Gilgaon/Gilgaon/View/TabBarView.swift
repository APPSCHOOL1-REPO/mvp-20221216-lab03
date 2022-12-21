//
//  TabBarView.swift
//  HanselAndGretel
//
//  Created by zooey on 2022/11/29.
//

import SwiftUI

enum SelectedTab {
    case first
    case second
}

struct TabBarView: View {
    
    @Binding var selectedTabBar: SelectedTab
    
    var body: some View {
        
        ZStack {
            Color("White")
                .ignoresSafeArea()
            
            HStack(spacing: 100) {
                
                Button {
                    selectedTabBar = .first
                } label: {
                    ZStack {
                        
                        if selectedTabBar == .first {
                            Image("line2")
                                .resizable()
                                .frame(width: 60, height: 60)
                        } else {
                            Image("line")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        
                        Text("서랍")
                            .font(.custom("NotoSerifKR-Regular", size: 18))
                            .foregroundColor(selectedTabBar == .first ? Color("Pink") : Color("DarkGray"))
                            .offset(y: -3)
                    }
                }
                
                Button {
                    selectedTabBar = .second
                } label: {
                    ZStack {
                        if selectedTabBar == .second {
                            Image("line2")
                                .resizable()
                                .frame(width: 60, height: 60)
                        } else {
                            Image("line")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        
                        Text("달력")
                            .font(.custom("NotoSerifKR-Regular", size: 18))
                            .foregroundColor(selectedTabBar == .second ? Color("Pink") : Color("DarkGray"))
                            .offset(y: -3)
                    }
                }
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTabBar: .constant(.first))
    }
}


