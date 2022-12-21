//
//  RecordView.swift
//  HanselAndGretel
//
//  Created by zooey on 2022/11/29.
//

import SwiftUI

//MARK: - 안쓰는 뷰
struct TripItem: Identifiable {
    var id = UUID()
    var imageName: String
    
}

struct RecordView: View {
    
    @State private var tripDay: [TripItem] = [
        
        TripItem(imageName: "b05"),
        TripItem(imageName: "b06"),
        TripItem(imageName: "b07"),
        TripItem(imageName: "b08"),
        TripItem(imageName: "b00"),
        TripItem(imageName: "b01"),
        TripItem(imageName: "b02"),
        TripItem(imageName: "b03"),
        TripItem(imageName: "b04"),
        TripItem(imageName: "b05"),
        TripItem(imageName: "b06"),
        TripItem(imageName: "b07"),
        TripItem(imageName: "b08"),
        TripItem(imageName: "b00"),
        TripItem(imageName: "b01"),
        TripItem(imageName: "b02"),
        TripItem(imageName: "b03"),
        TripItem(imageName: "b04")
        
    ]
    
    @State var show = false
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        ZStack {
            Color("White")
                .ignoresSafeArea()
            
            VStack {
                ZStack(alignment: .leading) {
                    MyPath3()
                        .stroke(Color("Pink"))
                    Text("서   랍")
                        .font(.custom("NotoSerifKR-Bold", size: 30))
                        .foregroundColor(Color("DarkGray"))
                        .padding(.leading, 50)
                }
                .frame(height: 50)
                .padding(.bottom, 5)
                
                ScrollView {
                    
                    LazyVGrid(columns: adaptiveColumns, spacing: 3) {
                        ForEach(tripDay) { day in
                            NavigationLink {
//                                FlowerMapView()
//                                DayView()
                            } label: {
                                Image(day.imageName)
                                    .resizable()
                                    .frame(width: 126, height: 126)
                            }
                            
                            
                            
                        }
                    }
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .padding(.vertical)
                }
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}

struct MyPath3: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.move(to: CGPoint(x: 20, y: 0))
        path.addLine(to: CGPoint(x: 160, y: 0))
        
        path.move(to: CGPoint(x: 20, y: 3))
        path.addLine(to: CGPoint(x: 160, y: 3))
        
        path.move(to: CGPoint(x: 20, y: 50))
        path.addLine(to: CGPoint(x: 160, y: 50))
        
        path.move(to: CGPoint(x: 20, y: 53))
        path.addLine(to: CGPoint(x: 160, y: 53))
        
        path.move(to: CGPoint(x: 40, y: 3))
        path.addLine(to: CGPoint(x: 40, y: 50))
        
        path.move(to: CGPoint(x: 90, y: 3))
        path.addLine(to: CGPoint(x: 90, y: 50))
        
        path.move(to: CGPoint(x: 140, y: 3))
        path.addLine(to: CGPoint(x: 140, y: 50))
        
        return path
    }
}
