//
//  CrosswordPresenter.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 04.07.2022.
//

import UIKit
import CoreData

protocol CrosswordViewOutput: AnyObject {
    init(view: CrosswordViewInput, router: CrosswordRouterProtocol)
    func saveTask(at screen: Screens)
}

final class CrosswordPresenter: CrosswordViewOutput {
    
    private weak var view: CrosswordViewInput?
    private let router: CrosswordRouterProtocol
    
    init(view: CrosswordViewInput, router: CrosswordRouterProtocol) {
        self.view = view
        self.router = router
    }
}

// MARK: - Core Data
extension CrosswordPresenter {
    func saveTask(at screen: Screens) {
        guard
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        else { return }

        let fetchResult = fetch(context)
        let index = Screens.allCases.firstIndex(of: screen) ?? 0 as Int
        let managedObject = fetchResult[index]
        managedObject.setValue(true, forKey: CDKeys.isCompleted)
        save(context)
    }
}

private extension CrosswordPresenter {
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
