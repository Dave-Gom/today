//
//  ViewController.swift
//  today
//
//  Created by Dave on 2025-06-11.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    var dataSource: DataSource?
    var reminders: [Reminder] = Reminder.sampleData

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(
            handler: cellRegistrationHandler
        )
        
        
        dataSource = DataSource(
            collectionView: collectionView
        ) {
            (
                collectionView: UICollectionView,
                indexPath: IndexPath,
                itemIdentifier: Reminder.ID
            ) in
            return collectionView
                .dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: itemIdentifier
                )
        }
        
        updateSnapshot()
        
        collectionView.dataSource = dataSource
    }
    
    override func collectionView
    ( _ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath ) -> Bool {
        let id = reminders[indexPath.item].id
        pushDetailViewForReminder(with: id)
        return false
    }
    
    
    func pushDetailViewForReminder(with id: Reminder.ID){
        let reminder = reminder(withId: id)
        let viewController = ReminderViewController(reminder: reminder)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    private func listLayout() -> UICollectionViewCompositionalLayout{
        var listConfiguration = UICollectionLayoutListConfiguration(
            appearance: .grouped
        )
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout
            .list(
                using: listConfiguration
            )
    }
    
  

}

