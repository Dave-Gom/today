//
//  TodayError.swift
//  RemindersApp
//
//  Created by Dave on 2025-11-03.
//
import Foundation

enum TodayError: LocalizedError {
    
    case accessDenied
    case accessRestricted
    case failedReadingReminders
    case reminderHasNoDueDate
    case failedReadingCalendarItem
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .accessDenied:
            return NSLocalizedString("The app does not have access to your reminders", comment: "acces denied error description")
        case .failedReadingReminders:
            return NSLocalizedString("Failed to read reminders", comment: "failed reading reminders error description")
        case .reminderHasNoDueDate:
            return NSLocalizedString("A reminder has no due date", comment: "reminder has no due date error description")
        case .accessRestricted:
            return NSLocalizedString("This device does not allow access to reminders", comment: "acces restricted error description")
        case .failedReadingCalendarItem:
            return NSLocalizedString("Failed to read calendar item.", comment: "failed  reading calendar item error description")
        case .unknown:
            return NSLocalizedString("An unknown erro occured", comment: "unknown error description")
        }
    }
}
