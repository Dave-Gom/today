//
//  ViewController.swift
//  RemindersApp
//
//  Created by Dave Gomez on 2025-08-06.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    var dataSource: DataSource?
    var reminders: [Reminder] = []
    var listStyle: ReminderListStyle = .today
    
    var filteredReminders: [Reminder] {
        return reminders.filter { listStyle.shouldInclude(date: $0.dueDate) }.sorted {
            $0.dueDate < $1.dueDate
        }
    }
    
    let listStyleSegmentedControl = UISegmentedControl(items: [
        ReminderListStyle.today.name,
        ReminderListStyle.future.name,
        ReminderListStyle.all.name
    ])
    var headerView: ProgressHeaderView?
    var progress: CGFloat {
        let chunckSize = 1.0 / CGFloat(filteredReminders.count)
        let progress = filteredReminders.reduce(0.0) {
            let chunk = $1.isComplete ? chunckSize: 0
            
            return $0 + chunk;
        }
        return progress
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .todayGradientFutureBegin
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: ProgressHeaderView.elementKind, handler: suplementaryRegistrationHandler)
        
        dataSource?.supplementaryViewProvider = { _, _, indexpath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexpath)
        }

        let addButton = UIBarButtonItem(
           barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = NSLocalizedString(
           "Add reminder", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton
       
        listStyleSegmentedControl.selectedSegmentIndex = listStyle.rawValue
        listStyleSegmentedControl.addTarget(self, action: #selector(didchangeListStyles(_:)), for: .valueChanged)
        navigationItem.titleView = listStyleSegmentedControl
            
        navigationItem.style = .navigator


        updateSnapshot()

        collectionView.dataSource = dataSource
        
        prepareReminderStore()
       }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = filteredReminders[indexPath.item].id
        pushDetailViewForReminder(with: id)
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        guard elementKind == ProgressHeaderView.elementKind,
            let progressView = view as? ProgressHeaderView
        else {
            return
        }
        
        progressView.progress = progress
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresahBackground()
    }
    
    func refresahBackground() {
        collectionView.backgroundView = nil
        let bacgroundView = UIView()
        let gradientLayer = CAGradientLayer.gradientLayer(for: listStyle, in: collectionView.frame)
        bacgroundView.layer.addSublayer(gradientLayer)
        collectionView.backgroundView = bacgroundView
    }
    
    // esto hace la navegacion
    func pushDetailViewForReminder(with id: Reminder.ID){
        let reminder = reminder(withId: id)
        let viewController = ReminderViewController(reminder: reminder, onChange: {
            [weak self] reminder in
            self?.updateReminder(reminder)
            self?.updateSnapshot(reloading: [reminder.id])
        })
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showError(_ error: Error) {
        let alertTilte = NSLocalizedString("Error", comment: "Error alert title")
        let alert = UIAlertController(title: alertTilte, message: error.localizedDescription, preferredStyle: .alert)
        let actionTitle = NSLocalizedString("Ok", comment: "Alert OK button Title")
        alert.addAction(
            UIAlertAction(
                title: actionTitle,
                style: .default,
                handler: { [weak self] _ in
                    self?.dismiss(animated: true)
                }
            )
        )
        present(alert, animated: true, completion: nil)
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.headerMode = .supplementary
        listConfiguration.showsSeparators = false
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }

    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath, let id = dataSource?.itemIdentifier(for: indexPath) else {
            return nil
        }
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete Action")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle, handler: {
            [weak self] _, _, completion in
            self?.deleteReminder(withId: id)
            self?.updateSnapshot()
            completion(false)
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func suplementaryRegistrationHandler(progressView: ProgressHeaderView, elementKing: String, indexPath: IndexPath) {
        headerView = progressView
    }
    
}

