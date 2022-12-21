//
//  DateTask.swift
//  Gilgaon
//
//  Created by zooey on 2022/11/29.
//

import SwiftUI

struct DateTask: Identifiable {
    var id = UUID().uuidString
    var title: String
    var taskDate: Date
    var realDate: [String]
    var time: Date = Date()
}

//struct TaskMetaData: Identifiable {
//    var id = UUID().uuidString
//    var dateTask: DateTask
//    var taskDate: Date
//}

class CalendarViewModel: ObservableObject,Identifiable {
    @Published var tasks: [DateTask]
    init() {
        let tasks = CalendarModel.selectDayInfo
        self.tasks = tasks
    }
}

class CalendarModel {
    static var selectDayInfo: [DateTask] = []
}



func getSampleDate(offset: Int) -> Date {
    
    let calender = Calendar.current
    
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
    
}

var tasks: [DateTask] = []
