//
//  TasksRouterProtocol.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 09.06.2022.
//

import UIKit

protocol TasksRouterProtocol {
    init(view: UIViewController)
    func moveToTasks() // Here will be transition to some task
}
