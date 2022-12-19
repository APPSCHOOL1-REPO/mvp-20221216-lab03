//
//  TaskViewModel.swift
//  Gilgaon
//
//  Created by zooey on 2022/12/01.
//

import SwiftUI


// 빨간점의 달력 날짜를 꽃갈피에서 클릭했을 때 보이는 뷰의 모델

class TaskViewModel: ObservableObject {
    
    @Published var storedTasks: [DayTask] = [
//    
//        DayTask(taskTitle: "예쁜 카페발견!", taskDescription: "돌아다니기 개꿀잼", taskDate: .init(timeIntervalSince1970: 1669766400)),
//        DayTask(taskTitle: "여기 진짜 맛집임 ㅜㅜ", taskDescription: "돌아다니기 개꿀잼", taskDate: .init(timeIntervalSince1970: 1669767400)),
//        DayTask(taskTitle: "너무 즐거운하루", taskDescription: "돌아다니기 개꿀잼", taskDate: .init(timeIntervalSince1970: 1669852800)),
//        DayTask(taskTitle: "소소하지만 즐거웠음", taskDescription: "돌아다니기 개꿀잼", taskDate: .init(timeIntervalSince1970: 1669892400)),
//        DayTask(taskTitle: "하루가 행복하당ㅎㅎ", taskDescription: "돌아다니기 개꿀잼", taskDate: .init(timeIntervalSince1970: 1669914000)),
//        DayTask(taskTitle: "여기 천국인가 ... ?", taskDescription: "돌아다니기 개꿀잼", taskDate: .init(timeIntervalSince1970: 1669802400)),
//        DayTask(taskTitle: "함께라서 더 좋아", taskDescription: "돌아다니기 개꿀잼", taskDate: .init(timeIntervalSince1970: 1669716000)),
//        DayTask(taskTitle: "힘들었지만 재밌었어 ^_^", taskDescription: "돌아다니기 개꿀잼", taskDate: .init(timeIntervalSince1970: 1669629600)),
//        DayTask(taskTitle: "예쁜 카페발견!", taskDescription: "돌아다니기 개꿀잼", taskDate: .init(timeIntervalSince1970: 1669644000))
    
    ]
    
    @Published var currentWeek: [Date] = []
    
    @Published var currentDay: Date = Date()
    
    @Published var filteredTasks: [DayTask]?
    
    init() {
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    func filterTodayTasks() {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let calendar = Calendar.current
            
            let filtered = self.storedTasks.filter {
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek() {
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ko")
        
        return formatter.string(from: date)
        
    }
    
    func isToday(date: Date) -> Bool {
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
