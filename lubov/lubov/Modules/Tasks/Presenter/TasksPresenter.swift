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
    
    // MARK: - Initializers

    init(view: TasksViewInput, router: TasksRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Methods

    // Moves
    func moveToTasks() {
        router.moveToTasks()
    }
    
}

// MARK: UICollectionViewDataSource
extension TasksPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3 // Заменить на динамик
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TasksCellCollectionViewCell.reuseId,
            for: indexPath
        ) as? TasksCellCollectionViewCell else { return UICollectionViewCell() }
    
        print(indexPath)
        
        // С тегами не получилось, поэтому для порядкового номера будем брать indexPath.row
        cell.configure(
            TasksCellCollectionViewCell.Model(
                numberOfTask: indexPath.row
            )
        )
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension TasksPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Обработать нажатие на ячейку
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
