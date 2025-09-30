//
//  ReminderListViewController+Actions.swift
//  RemindersApp
//
//  Created by Dave Gomez on 2025-08-12.
//
import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else {
            print ("Error: No ID found for the button")
            return
        }
        completeReminder(withId: id)
    }
}
