//
//  CoreData+Ext.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 29.06.2022.
//

import UIKit
import CoreData

extension TasksPresenter {
    func fetchTasks() -> [Task] {
        guard
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        else { return [] }
        
        return fetch(context)
    }
    
    func makeTasks() -> [Task] {
        guard
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        else { return [] }
        
        let result = TaskStorage.names.enumerated().map { index, name in
            makeTask(name, index, context)
        }
        save(context)
        
        return result
    }
}

private extension TasksPresenter {
    func makeTask(
        _ name: String,
        _ index: Int,
        _ context: NSManagedObjectContext
    ) -> Task {
        let task = Task(context: context)
        task.descriptionTask = name
        task.id = Int16(index)
        task.isCompleted = false
        return task
    }
    
    func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetch(_ context: NSManagedObjectContext) -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
