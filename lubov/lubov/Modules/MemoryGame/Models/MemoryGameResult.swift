//
//  MemoryGame.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 05.07.2022.
//

import Foundation

struct MemoryGameResult {
    let flipFirstCell: Bool
    let backFlipFirstCell: Bool
    let backFlipSecondCell: Bool
    let removeFirstCell: Bool
    let removeSecondCell: Bool
    let flippedIndex: IndexPath?
    
    static func empty() -> Self {
        .init(
            flipFirstCell: false,
            backFlipFirstCell: false,
            backFlipSecondCell: false,
            removeFirstCell: false,
            removeSecondCell: false,
            flippedIndex: nil
        )
    }
}
