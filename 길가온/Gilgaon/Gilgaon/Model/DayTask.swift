//
//  DayTask.swift
//  Gilgaon
//
//  Created by zooey on 2022/12/01.
//

import Foundation

struct DayTask: Identifiable {
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
