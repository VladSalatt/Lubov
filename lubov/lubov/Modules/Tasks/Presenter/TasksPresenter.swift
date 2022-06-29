//
//  TasksPresenter.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 31.05.2022.
//

import UIKit
import CoreData

final class TasksPresenter: NSObject, TasksViewOutput {
    
    // MARK: - Properties

    private weak var view: TasksViewInput?
    private let router: TasksRouterProtocol
    private var userDefaults: UserDefaultsStorage
    private var tasks = [Task]()
    
    // MARK: - Initializers

    init(
        view: TasksViewInput,
        router: TasksRouterProtocol,
        userDefaults: UserDefaultsStorage
    ) {
        self.view = view
        self.router = router
        self.userDefaults = userDefaults
        super.init()
        configureTasks()
    }
    
    // MARK: - Methods

    // Moves
    func moveToTask(at screen: Screens) {
        router.moveToTask(at: screen)
    }
    
    func configureTasks() {
        guard !userDefaults.isSecondOpen else {
            self.tasks = fetchTasks()
            return
        }
        userDefaults.isSecondOpen = true
        
        self.tasks = makeTasks()
    }
}

// MARK: UICollectionViewDataSource

extension TasksPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TasksCellCollectionViewCell.reuseId,
            for: indexPath
        ) as? TasksCellCollectionViewCell else { return UICollectionViewCell() }
        let task = tasks[indexPath.row]
        
        cell.configure(with: .init(task))
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension TasksPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextScreen = Screens.allCases[indexPath.row]
        moveToTask(at: nextScreen)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

private extension TasksCellCollectionViewCell.Model {
    init(_ model: Task) {
        descriptionOfTask = model.descriptionTask
    }
}
