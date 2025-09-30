//
//  ReminderViewController+Section.swift
//  RemindersApp
//
//  Created by Dave Gomez on 2025-09-30.
//

import Foundation

extension ReminderViewController {
    enum Section: Int, Hashable {
        case view
        case title
        case date
        case notes
        
        var name: String {
            switch self {
            case .view:
                return  ""
            case .title:
                return NSLocalizedString("Title", comment: "Title section name")
            case .date:
                return NSLocalizedString("Date", comment: "Date section Name")
            case .notes:
                return NSLocalizedString("Notes", comment: "Notes section name")
            }
        }
    }
}
