//
//  TodayError.swift
//  RemindersApp
//
//  Created by Dave on 2025-11-03.
//
import Foundation

enum TodayError: LocalizedError {
    
    case failedReadingReminders
    
    var errorDescription: String? {
        switch self {
        case .failedReadingReminders:
            return NSLocalizedString("Failed to read reminders", comment: "failed reading reminders error description")
        }
    }
}
