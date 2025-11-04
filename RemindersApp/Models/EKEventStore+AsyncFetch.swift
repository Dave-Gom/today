//
//  EKEventStore+AsyncFetch.swift
//  RemindersApp
//
//  Created by Dave on 2025-11-03.
//

import EventKit
import Foundation

extension EKEventStore {
    func reminders(matching predicate: NSPredicate) async throws -> [EKReminder] {
        try await withCheckedThrowingContinuation { continuation in
            fetchReminders(matching: predicate, completion: {
                reminders in
                if let reminders {
                    continuation.resume(returning: reminders)
                }
                else{
                    continuation.resume(throwing: TodayError.failedReadingReminders)
                }
            })
        }
    }
}
