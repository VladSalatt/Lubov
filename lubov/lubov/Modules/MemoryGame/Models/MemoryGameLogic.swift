//
//  MemoryGame.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 05.07.2022.
//

import Foundation

final class MemoryGameLogic {
    
    // MARK: - Properties
    
    var cards = [Card]()
    var flippedIndex: IndexPath?
    
    // MARK: - Init
    
    init() {
        self.cards = setInitialCards()
    }
}

// MARK: - Methods

extension MemoryGameLogic {
    func setInitialCards() -> [Card] {
        let cards = CardStorage.initialCards + CardStorage.initialCards
        return cards.shuffled().shuffled()
    }
    
    func card(at index: Int) -> Card {
        cards[index]
    }
    
    func matchCards(firstIndex: Int, secondIndex: Int) -> Bool {
        guard
            cards[firstIndex].frontImageName == cards[secondIndex].frontImageName
        else { return false }

        cards[firstIndex].isMatched = true
        cards[secondIndex].isMatched = true
        return true
    }
    
    func toggleFlip(for index: Int) {
        cards[index].isFlipped.toggle()
    }
    
    func allMatched() -> Bool {
        cards.allSatisfy { $0.isMatched }
    }
}

// MARK: - Main Logic

extension MemoryGameLogic {
    func cardSelected(
        _ secondCellExist: Bool,
        _ selectedIndexPath: IndexPath
    ) -> MemoryGameResult {
        let card = card(at: selectedIndexPath.item)
        var result: (
            flipFirstCell: Bool,
            backFlipFirstCell: Bool,
            backFlipSecondCell: Bool,
            removeFirstCell: Bool,
            removeSecondCell: Bool,
            flippedIndex: IndexPath?
        )
        
        guard !card.isFlipped && !card.isMatched else {
            return .empty()
        }
        
        if let secondCardIndexPath = flippedIndex {
            let isMatch = matchCards(
                firstIndex: selectedIndexPath.item,
                secondIndex: secondCardIndexPath.item
            )
            if secondCellExist {
                result.removeFirstCell = isMatch ? true : false
                result.removeSecondCell = isMatch ? true : false
                // Flip both over
                result.backFlipSecondCell = true
            } else {
                // The second cell is offscreen
                // Match the cards if they match
                result.removeFirstCell = isMatch ? true : false
                result.backFlipSecondCell = false
                result.removeSecondCell = false
            }
            result.backFlipFirstCell = true

            // No more cards are flipped
            result.flippedIndex = flippedIndex
            flippedIndex = nil
            toggleFlip(for: selectedIndexPath.item)
            toggleFlip(for: secondCardIndexPath.item)
        } else {
            // Only one card is flipped
            flippedIndex = selectedIndexPath
            result.flippedIndex = nil
            
            result.backFlipFirstCell = false
            result.backFlipSecondCell = false
            result.removeFirstCell = false
            result.removeSecondCell = false
        }
        
        // Flip the selected card
        toggleFlip(for: selectedIndexPath.item)
        result.flipFirstCell = true
        return .init(
            flipFirstCell: result.flipFirstCell,
            backFlipFirstCell: result.backFlipFirstCell,
            backFlipSecondCell: result.backFlipSecondCell,
            removeFirstCell: result.removeFirstCell,
            removeSecondCell: result.removeSecondCell,
            flippedIndex: result.flippedIndex
        )
    }
}
