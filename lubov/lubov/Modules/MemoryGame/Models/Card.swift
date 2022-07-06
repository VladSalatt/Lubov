//
//  Card.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 05.07.2022.
//

import Foundation

struct Card: Equatable {
    var frontImageName: String
    var backImageName: String
    var isMatched: Bool
    var isFlipped: Bool
}
