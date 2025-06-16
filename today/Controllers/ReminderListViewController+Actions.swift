//
//  ReminderListViewController+Actions.swift
//  today
//
//  Created by Dave on 2025-06-14.
//
import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton){
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
}
