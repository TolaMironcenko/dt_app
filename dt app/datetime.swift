//
//  datetime.swift
//  dt
//
//  Created by Анатолий Миронченко on 31.01.2023.
//

import Foundation

// function for get now date and time
func getDateTimeNow(what: String? = nil) -> String {
    let date = Date()
    let calendar = Calendar.current
    
    let year = calendar.component(.year, from: date)
    let month = calendar.component(.month, from: date)
    let day = calendar.component(.day, from: date)
    let hour = calendar.component(.hour, from: date)
    let minute = calendar.component(.minute, from: date)
    if (what == "time") {
        return "\(hour):\(minute)"
    }
    if (what == "date") {
        return "\(day)-\(month)-\(year)"
    }
    return "\(day)-\(month)-\(year) \(hour):\(minute)"
}
