//
//  Customtoggle.swift
//  Gilgaon
//
//  Created by zooey on 2022/11/30.
//

import Foundation
import SwiftUI

struct Customtoggle: View {
    
    @Binding var show: Bool
    
    var body: some View {
        
        
        HStack {
            
            ZStack {
                Capsule()
                    .fill(show == true ? Color("Pink") : Color("DarkGray"))
                    .frame(width: 55, height: 100)
                
                VStack {
                    
                    if !show {
                        
                        Spacer()
                        
                    }
                    
                    ZStack {
                        Circle()
                            .fill(Color("White"))
                            .frame(width: 40, height: 40)
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            self.show.toggle()
                        }
                    }
                    
                    if show {
                        
                        Spacer()
                        
                    }
                }
                .frame(width: 40, height: 80)
            }
            
            VStack {
                Text("N")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(show == true ? Color("Pink") : Color("Withe"))
                Text("FF")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(show == true ? Color("White") : Color("DarkGray"))
            }
        }
    }
}
