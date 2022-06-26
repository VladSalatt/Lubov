//
//  TasksPresenter.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 31.05.2022.
//

import UIKit

final class TasksPresenter: NSObject, TasksViewOutput {
    
    // MARK: - Properties

    private weak var view: TasksViewInput?
    private let router: TasksRouterProtocol
    private var tasks: [TaskProtocol]
    
    // MARK: - Initializers

    init(view: TasksViewInput, router: TasksRouterProtocol) {
        self.view = view
        self.router = router
        self.tasks = [
            Task(descriptionTask: "Узнаешь его по квадратности :-D"),
            Task(descriptionTask: "Second Task"),
            Task(descriptionTask: "Third Task"),
            Task(descriptionTask: "Fourth Task"),
            Task(descriptionTask: "Fifth Task"),
            Task(descriptionTask: "Sixth Task")
        ]
    }
    
    // MARK: - Methods

    // Moves
    func moveToTask(at screen: Screens) {
        router.moveToTask(at: screen)
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
    init(_ model: TaskProtocol) {
        descriptionOfTask = model.descriptionTask
    }
}
