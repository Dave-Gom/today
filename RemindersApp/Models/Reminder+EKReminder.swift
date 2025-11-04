//
//  Reminder+EKReminder.swift
//  RemindersApp
//
//  Created by Dave Gomez on 2025-11-04.
//
import EventKit
import Foundation

extension Reminder {
    init(with ekreminder: EKReminder) throws {
        guard let dueDate = ekreminder.alarms?.first?.absoluteDate else {
            throw TodayError.reminderHasNoDueDate
        }
        
        id = ekreminder.calendarItemIdentifier
        title = ekreminder.title
        self.dueDate = dueDate
        notes = ekreminder.notes
        isComplete = ekreminder.isCompleted
    }
}
