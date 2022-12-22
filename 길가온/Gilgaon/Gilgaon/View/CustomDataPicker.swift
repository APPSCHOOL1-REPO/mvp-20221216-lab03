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
    
    let days: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    var body: some View {
        ScrollView{
            ScrollViewReader { value in
                VStack(spacing: 35) {
                    
                    VStack(spacing: 20) {
                        HStack(spacing: 20) {
                            Button {
                                currentMonth -= 1
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
                                currentMonth += 1
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
                                            calID = extraDate()
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
                        // 달력 밑에 데이터 보여주고 싶으면 여기에
                    }
                    .padding()
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
        
        return path
    }
}
