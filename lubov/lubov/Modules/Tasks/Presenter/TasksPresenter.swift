//
//  TasksPresenter.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 31.05.2022.
//

import UIKit

final class TasksPresenter: TasksViewOutput {
    
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
