//
//  CalendarSelectView.swift
//  Gilgaon
//
//  Created by zooey on 2023/03/07.
//

import SwiftUI

struct Test: Identifiable, Hashable {
    var id = UUID()
    var date: String
    var location: String
}

struct CalendarSelectView: View {
    
    var array: [Test] = [
        Test(date: "11:32", location: "명동"),
        Test(date: "12:14", location: "명동칼국수"),
        Test(date: "13:27", location: "스타벅스 명동점"),
        Test(date: "17:58", location: "명동 돈까스"),
        Test(date: "18:46", location: "명동 와인바"),
    ]
    
    @ObservedObject var flowerMapViewModel: FlowerMapViewModel
    @State var getStringValue: String
    
    var body: some View {
        
        ZStack {
            Color("White")
                .ignoresSafeArea()
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    ForEach(flowerMapViewModel.locations, id: \.self) { item in
                        VStack {
                            HStack {
                                Rectangle()
                                    .frame(height: 1)
                                
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .background(
                                        Circle()
                                            .stroke(lineWidth: 1)
                                            .padding(-3)
                                    )
                                
                                Rectangle()
                                    .frame(height: 1)
                            }
                            
                            VStack {
                                Text(item.createdDate)
                                Text(item.locationName)
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("Pink"), lineWidth: 1.5)
                            }
                        }
                    }
                    .foregroundColor(Color("DarkGray"))
                    .font(.custom("NotoSerifKR-Regular", size: 18))
                }
                .padding()
            }
        }
    }
}
struct CalendarSelectView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarSelectView(flowerMapViewModel: FlowerMapViewModel(), getStringValue: "")
    }
}


