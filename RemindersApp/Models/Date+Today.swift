//
//  Date+Today.swift
//  RemindersApp
//
//  Created by Dave Gomez on 2025-08-07.
//
import Foundation

extension Date {
    var dayAndTimeText: String {
        let timeText = formatted(date: .omitted, time: .shortened)
        if Locale.current.calendar.isDateInToday(self){
            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format string")
            return String(format: timeFormat, timeText)
        }
        else{
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateAndTimeFormat = NSLocalizedString("%@ at %@", comment: "Date And time formated string")
            return String(format: dateAndTimeFormat, dateText, timeText)
        }
    }
    
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "Today Due Date Description")
        }
        else{
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
