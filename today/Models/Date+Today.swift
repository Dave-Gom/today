//
//  Date+Today.swift
//  today
//
//  Created by Dave on 2025-06-14.
//

import Foundation


extension Date {
    var dayAndTimeText: String {
        let timeText = formatted(date: .omitted, time: .shortened)
        
        if Locale.current.calendar.isDateInToday(self){
            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format")
            return String(format: timeFormat, timeText)
        }
        else{
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateAndTimeFormatted = NSLocalizedString("%@ at %@", comment: "Date and time format")
            return String(format: dateAndTimeFormatted, dateText, timeText)
        }
    }
    
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self){
            return NSLocalizedString("Today", comment: "Today due date description")
        }
        else{
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
