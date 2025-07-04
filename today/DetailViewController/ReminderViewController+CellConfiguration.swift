//
//  ReminderViewController+CellConfiguration.swift
//  today
//
//  Created by Dave on 2025-07-05.
//

import UIKit

extension ReminderViewController {
    
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration{
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = .preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image;
        
        return contentConfiguration
    }
    
    func headerCOnfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        
        return contentConfiguration;
    }
    
    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Configuration {
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = title
        return contentConfiguration
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        default:
            return nil
        }
    }
}
