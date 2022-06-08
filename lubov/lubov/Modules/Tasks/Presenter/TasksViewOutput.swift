//
//  TasksViewOutpur.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 31.05.2022.
//

protocol TasksViewOutput: AnyObject {
    init(view: TasksViewInput, router: TasksRouterProtocol)
    func moveToTasks() // call same func in router
}
