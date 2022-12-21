//
//  CustomDataPicker.swift
//  Gilgaon
//
//  Created by zooey on 2022/11/29.
//

import SwiftUI

struct CustomDataPicker: View {
    @EnvironmentObject var fireStoreModel: FireStoreViewModel
    
    
    
    @State var currentDate = Date()
    @Binding var calID: [String]
    @State var currentMonth: Int = 0
    //+버튼을 눌렀을 때 화면아래로 이동하게 설정해주는 변수
    @Namespace var bottomID
    let days: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    //토글을 값에 따른 뷰 구성을 위해 변수 선언
    @State private var toggleValue: Bool = false
    
    @State private var showInSheet: Bool = false
    
    @State private var mapshowInSheet: Bool = false
    
    
    var searchNetwork: SearchNetwork = SearchNetwork()
    @EnvironmentObject var viewModel: SearchViewModel
    @EnvironmentObject private var cvm: CalendarViewModel
    
    
    
    
    var body: some View {
        ScrollView{
            ScrollViewReader { value in
            VStack(spacing: 35) {
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        Button {
                            
                            withAnimation {
                                currentMonth -= 1
                            }
                            
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(Color("Pink"))
                        }
                        
                        Spacer()
                        
                        VStack() {
                            Text(extraDate()[0])
                                .font(.custom("NotoSerifKR-SemiBold", size: 15))
                                .foregroundColor(Color("DarkGray"))
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            
                            withAnimation {
                                currentMonth += 1
                            }
                            
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .foregroundColor(Color("Pink"))
                        }
                    }
                    .padding(.horizontal)
                    
                    ZStack {
                        MyPath4()
                            .stroke(Color("Pink"))
                        
                        HStack {
                            Text(extraDate()[1])
                            Text("월")
                            
                        }
                        .font(.custom("NotoSerifKR-Bold", size: 30))
                        .foregroundColor(Color("DarkGray"))
                        .padding(.top, 7)
                    }
                }
                
                
                ZStack {
                    
                    MyPath5()
                        .stroke(Color("DarkGray"))
                    VStack {
                        HStack(spacing: 0) {
                            
                            //월화수목금토일 띄워주는 ForEach
                            ForEach(days, id: \.self) { day in
                                
                                Text(day)
                                    .font(.custom("NotoSerifKR-SemiBold", size: 15))
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.bottom, 20)
                        
                        let columns = Array(repeating: GridItem(.flexible()), count: 7)
                        
                        LazyVGrid(columns: columns, spacing: 5) {
                            ForEach(extractDate()) { value in
                                CardView(value: value)
                                    .background(
                                        Capsule()
                                            .fill(Color("Pink"))
                                            .padding(.horizontal, 8)
                                            .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                    )
                                    .onTapGesture {
                                        currentDate = value.date
//                                        print("currentDate:",currentDate)
//                                        print(value.date,currentDate)
                                        calID = extraDate()
//                                        print("calID:",calID)
//                                        print(fireStoreModel.calendarList)
//                                        print(fireStoreModel.)

//                                        print("value.id:",value.id)
//                                        calID = value.id
//                                        print(calID)
                                    }
                                
                            }
                        }
                        .onAppear {
                            fireStoreModel.fetchDayCalendar()
                        }
                    }
                    .offset(y: 20)
                }
                
                VStack(spacing: 15) {
                    HStack{
                        Text("꽃갈피")
                            .font(.custom("NotoSerifKR-Bold", size: 20))
                            .frame( alignment: .leading)
                            .foregroundColor(Color("DarkGray"))
                            .padding(.vertical, 20)
                        Image(systemName: "leaf")
                            .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                            .font(.title2)
                            .foregroundColor(Color("Pink"))
                        
                        Spacer()
                        
                        Button {
                            toggleValue.toggle()
                            value.scrollTo(bottomID)
//                            Task {
////                                viewModel.center = try await apiNetwork.loadJson(searchTerm: "성수")
//                                try await apiNetwork.loadJson(searchTerm: "성수")
//                            }
                        } label: {
                            Image(systemName: toggleValue ? "minus":"plus")
                                .font(.title3)
                                .foregroundColor(Color("DarkGray"))
                                .animation(.linear)
                        }
                        .padding(.trailing, 20)
                        
                    }
                    
//                    fireStoreModel.
                    if let dateTask = cvm.tasks.first(where: { task in
                        return isSameDay(date1: task.taskDate, date2: currentDate)
                    }) {
                        
                        NavigationLink(destination: DayView(calID: $calID)) {
                            
                            
//                            cvm.tasks.filter {$0.id.elementsEqual(calID)}
                            ForEach(cvm.tasks.filter {$0.realDate.contains(calID)}) { task in
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text("\(task.time)")
                                        .font(.custom("NotoSerifKR-SemiBold", size: 10))
                                    Text(task.title)
                                            .font(.custom("NotoSerifKR-Bold", size: 17))
                                    

                                }
                                .foregroundColor(Color("DarkGray"))
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    Color("Pink")
                                        .opacity(0.3)
                                        .cornerRadius(10)
                                )
                            }
                        }//NavigationLink
                        
                        
                    } else {
                        //MARK: 토글 스위치값에 따라 보여주는 뷰 다르게 설정하기 위함
                        if toggleValue {
                            VStack {
                                HStack {
                                    Text("꽃갈피 남기는 중...")
                                        .font(.custom("NotoSerifKR-Bold", size: 18))
                                        .foregroundColor(Color("DarkGray"))
                                    Image(systemName: "leaf")
                                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                                        .font(.title2)
                                        .foregroundColor(Color("Pink"))
                                }
                                .padding()
                                HStack(spacing: 30) {
                                    NavigationLink {
                                        WritingView(firestoreViewModel: FireStoreViewModel())
                                    } label: {
                                        Text("새 글작성")
                                            .font(.custom("NotoSerifKR-SemiBold", size: 15))
                                            .foregroundColor(Color("Pink"))
                                    }
                                    NavigationLink {
                                        FlowerMapView()
                                    } label: {
                                        Text("지도 보기")
                                            .font(.custom("NotoSerifKR-SemiBold", size: 15))
                                            .foregroundColor(Color("Pink"))
                                    }
                                }
                            }
                        }
                        else {
                            Text("만들어진 꽃갈피가 없습니다.")
                                .font(.custom("NotoSerifKR-SemiBold", size: 15))
                                .foregroundColor(Color("DarkGray"))
                        }
                        
                        
                    }
                    
                }
                .padding()
                .id(bottomID)
                
                
            }
            .onChange(of: currentMonth) { newValue in
                currentDate = getCurrentMonth()
            }
        }//ScrollView
    }
    }
    
    @ViewBuilder
    func CardView(value: DateVaule) -> some View {
        
        VStack {
            if value.day != -1 {
                
//                if cvm.tasks.count > 0 {
//
//                }
                if let dateTask = fireStoreModel.calendarList.first(where: { task1 in
                    return isSameDay(date1: task1.taskDate, date2: value.date)
                })
                {
                    
                    Text("\(value.day)")
                        .font(.custom("NotoSerifKR-SemiBold", size: 20))
                        .foregroundColor(isSameDay(date1: dateTask.taskDate, date2: currentDate) ? Color("White") : Color("DarkGray"))
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: dateTask.taskDate, date2: currentDate) ? Color("White") : Color("Pink"))
                        .frame(width: 8, height: 8)
                    
                }
                else {

                    Text("\(value.day)")
                        .font(.custom("NotoSerifKR-SemiBold", size: 20))
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? Color("White") : Color("DarkGray"))
                        .frame(maxWidth: .infinity)

                    Spacer()
                    
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
        
    }
    
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "YYYY MM dd"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    func extractDate() -> [DateVaule] {
        
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateVaule in
            let day = calendar.component(.day, from: date)
            
            return DateVaule(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateVaule(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}


struct CustomDataPicker_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}


extension Date {
    
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}


struct MyPath4: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.move(to: CGPoint(x: 150, y: 10))
        path.addLine(to: CGPoint(x: 250, y: 10))
        
        path.move(to: CGPoint(x: 150, y: 13))
        path.addLine(to: CGPoint(x: 250, y: 13))
        
        path.move(to: CGPoint(x: 150, y: 50))
        path.addLine(to: CGPoint(x: 250, y: 50))
        
        path.move(to: CGPoint(x: 150, y: 53))
        path.addLine(to: CGPoint(x: 250, y: 53))
        
        path.move(to: CGPoint(x: 160, y: 13))
        path.addLine(to: CGPoint(x: 160, y: 50))
        
        path.move(to: CGPoint(x: 197, y: 13))
        path.addLine(to: CGPoint(x: 197, y: 50))
        
        path.move(to: CGPoint(x: 240, y: 13))
        path.addLine(to: CGPoint(x: 240, y: 50))
        
        return path
    }
}

struct MyPath5: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        
        
        
        path.move(to: CGPoint(x: 5, y: 53))
        path.addLine(to: CGPoint(x: 385, y: 53))
        
        path.move(to: CGPoint(x: 5, y: 56))
        path.addLine(to: CGPoint(x: 385, y: 56))
        
        //        path.move(to: CGPoint(x: 55, y: 53))
        //        path.addLine(to: CGPoint(x: 55, y: 440))
        //
        //        path.move(to: CGPoint(x: 107, y: 53))
        //        path.addLine(to: CGPoint(x: 107, y: 440))
        
        //        path.move(to: CGPoint(x: 5, y: 350))
        //        path.addLine(to: CGPoint(x: 385, y: 350))
        //        path.move(to: CGPoint(x: 5, y: 353))
        //        path.addLine(to: CGPoint(x: 385, y: 353))
        //
        //
        //        path.move(to: CGPoint(x: 5, y: 430))
        //        path.addLine(to: CGPoint(x: 385, y: 430))
        //
        //        path.move(to: CGPoint(x: 5, y: 433))
        //        path.addLine(to: CGPoint(x: 385, y: 433))
        
        
        return path
    }
}
