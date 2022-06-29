//
//  TasksConfigurator.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 31.05.2022.
//

import UIKit

final class TasksConfigurator {
    static func configure() -> UIViewController {
        let view = TasksCVC(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: view)
        let router = TasksRouter(view: view)
        let presenter = TasksPresenter(view: view, router: router, userDefaults: UserDefaults.standard)
        view.presenter = presenter
        
        return navigationController
    }
}
