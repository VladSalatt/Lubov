//
//  SolomonTreasurePresenter.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 07.07.2022.
//

import UIKit
import CoreData
import AVFoundation

protocol SolomonTreasureViewProtocol: AnyObject {}

protocol SolomonTreasurePresenterProtocol {
    init(
        view: SolomonTreasureViewProtocol,
        router: SolomonTreasureRouterProtocol
    )
    func saveTask(at screen: Screens)
    func playSound()
}

final class SolomonTreasurePresenter: SolomonTreasurePresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: SolomonTreasureViewProtocol?
    private let router: SolomonTreasureRouterProtocol
    private var player: AVAudioPlayer?
    
    // MARK: - Initializers
    
    init(
        view: SolomonTreasureViewProtocol,
        router: SolomonTreasureRouterProtocol
    ) {
        self.view = view
        self.router = router
    }
    
    func playSound() {
        if player == nil {
            createPlayer()
        }
        player!.play()
    }
    
    private func createPlayer() {
        let soundUrl = Bundle.main.url(forResource: "s-dnem-birthday", withExtension: "mp3")
        guard let soundUrl = soundUrl else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundUrl)
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
}

// MARK: - Core Data

extension SolomonTreasurePresenter {
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

private extension SolomonTreasurePresenter {
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
