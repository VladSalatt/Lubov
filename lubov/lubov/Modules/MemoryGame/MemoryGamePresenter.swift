//
//  MemoryGamePresenter.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 05.07.2022.
//

import UIKit
import CoreData

protocol MemoryGameViewProtocol: AnyObject {}

protocol MemoryGamePresenterProtocol {
    init(
        view: MemoryGameViewProtocol,
        router: MemoryGameRouterProtocol,
        memoryGameLogic: MemoryGameLogic
    )
}

final class MemoryGamePresenter: NSObject, MemoryGamePresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: MemoryGameViewProtocol?
    private let router: MemoryGameRouterProtocol
    private let memoryGameLogic: MemoryGameLogic
    
    // MARK: - Initializers
    
    init(
        view: MemoryGameViewProtocol,
        router: MemoryGameRouterProtocol,
        memoryGameLogic: MemoryGameLogic
    ) {
        self.view = view
        self.router = router
        self.memoryGameLogic = memoryGameLogic
        super.init()
    }
    
}

extension MemoryGamePresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memoryGameLogic.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MemoryCardCell.reuseId,
            for: indexPath
        ) as? MemoryCardCell else {
            fatalError("Unable to dequeue a MemoryCardCell")
        }
        let card = memoryGameLogic.card(at: indexPath.item)
        cell.configure(with: .init(card))
        return cell
    }
}

extension MemoryGamePresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? MemoryCardCell
        else { fatalError("Ячейка не найдена") }
        
        var result: MemoryGameResult
        
        if let flippedIndex = memoryGameLogic.flippedIndex {
            if let _ = collectionView.cellForItem(at: flippedIndex) as? MemoryCardCell {
                result = memoryGameLogic.cardSelected(true, indexPath)
            } else {
                result = memoryGameLogic.cardSelected(false, indexPath)
            }
        } else {
            result = memoryGameLogic.cardSelected(false, indexPath)
        }
        
        // Flip or remove cell if needed
        flipOrRemoveCell(cell, collectionView, result)
        
        if memoryGameLogic.allMatched() { print("🔴SUCESSSS") }
    }
}

extension MemoryGamePresenter {
    func flipOrRemoveCell(
        _ firstCell: MemoryCardCell,
        _ collectionView: UICollectionView,
        _ result: MemoryGameResult
    ) {
        if result.flipFirstCell { firstCell.flip() }
        if result.backFlipFirstCell { firstCell.flipBack() }
        if result.removeFirstCell { firstCell.remove() }
        if result.backFlipSecondCell {
            guard let secondCell = collectionView.cellForItem(
                at: result.flippedIndex!
            ) as? MemoryCardCell else {
                fatalError("Вторая ячейка не создана")
            }
            secondCell.flipBack()
            
            if result.removeSecondCell { secondCell.remove() }
        }
    }
}

private extension MemoryCardCell.Model {
    init(_ model: Card) {
        guard
            let backImage = UIImage(named: model.backImageName),
            let frontImage = UIImage(named: model.frontImageName)
        else { fatalError("Такой картинки не существует, проверь название") }

        self.backImage = backImage
        self.frontImage = frontImage
        self.isMatched = model.isMatched
    }
}

// MARK: - Core Data

extension MemoryGamePresenter {
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

private extension MemoryGamePresenter {
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
