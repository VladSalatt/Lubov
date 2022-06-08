//
//  TakskRouter.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 09.06.2022.
//

import UIKit

final class TasksRouter: TasksRouterProtocol {
    
    // MARK: - Properties

    private weak var view: UIViewController?
    
    // MARK: - Initializers

    init(view: UIViewController) {
        self.view = view
    }
    
    // MARK: - Methods

    func moveToTasks() {
        guard let view = view, let navigationController = view.navigationController else { return }
        print("moveToTasks")
//        let viewController =
//        navigationController.pushViewController(viewController, animated: true)
    }
}
