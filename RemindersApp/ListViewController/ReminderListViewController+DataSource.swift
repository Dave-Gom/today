//
//  ReminderListViewController+DataSource.swift
//  RemindersApp
//
//  Created by Dave Gomez on 2025-08-11.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    var reminderCompleteValue: String {
        NSLocalizedString("Completed", comment: "Reminder complete value")
    }
    
    var reminderNotCompleteValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not complete value")
    }
    
    func updateSnapshot(reloading ids: [Reminder.ID] = []) {
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(reminders.map{ $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource?.apply(snapshot)
    }
    
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID){
        let reminder = reminder(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityValue = reminder.isComplete ? reminderCompleteValue : reminderNotCompleteValue
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration),
            .disclosureIndicator(displayed: .always)
        ]
        
        var backgroundConfiguration = UIBackgroundConfiguration.listCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    
    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfreminder(withId: id)
        return reminders[index]
    }
    
    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfreminder(withId: reminder.id)
        reminders[index] = reminder
    }
    
    func completeReminder(withId id: Reminder.ID){
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
    }
    
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle completition", comment: "Reminder done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name, actionHandler: {[weak self] action in
            self?.completeReminder(withId: reminder.id)
            return true
        })
        
        return action
        
    }
    
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = ReminderDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}
