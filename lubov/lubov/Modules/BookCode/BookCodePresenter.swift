//
//  BookCodePresenter.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 03.07.2022.
//

import UIKit
import CoreData

protocol BookCodeViewProtocol: AnyObject {}

protocol BookCodePresenterProtocol {
    init(
        view: BookCodeViewProtocol,
        router: BookCodeRouterProtocol
    )
    func saveTask(at screen: Screens)
}

final class BookCodePresenter: BookCodePresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: BookCodeViewProtocol?
    private let router: BookCodeRouterProtocol
    
    // MARK: - Initializers
    
    init(
        view: BookCodeViewProtocol,
        router: BookCodeRouterProtocol
    ) {
        self.view = view
        self.router = router
    }
    
}

// MARK: - Core Data

extension BookCodePresenter {
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

private extension BookCodePresenter {
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
