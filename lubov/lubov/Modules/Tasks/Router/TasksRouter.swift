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

    func moveToTask(at screen: Screens) {
        guard let view = view, let navigationController = view.navigationController else { return }
        var viewController: UIViewController
        switch screen {
        case .knownBySquare:
            viewController = KnownBySquareConfigurator.configure()
        case .bookCode:
            viewController = BookCodeConfigurator.configure()
        case .crossword:
            viewController = CrosswordConfigurator.configure()
        case .memoryGame:
            viewController = MemoryGameConfigurator.configure()
        case .fifth:
            viewController = UIViewController()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}
