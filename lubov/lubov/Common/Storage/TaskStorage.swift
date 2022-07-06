//
//  UserDefaults+FirstOpen.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 29.06.2022.
//

import Foundation

// TODO: Переместить в shared
// TODO: Добавить 8 картинок в CardStorage
protocol UserDefaultsStorage {
    var isSecondOpen: Bool { get set }
}

extension UserDefaults: UserDefaultsStorage {
    private static let isSecondOpenKey = "ru.lubov.is_second_open"
    
    var isSecondOpen: Bool {
        get {
            bool(forKey: Self.isSecondOpenKey)
        }
        set {
            set(newValue, forKey: Self.isSecondOpenKey)
        }
    }
}

struct TaskStorage {
    // TODO: Переименовать
    static let names: [String] = [
        "Имя им - КВАДРАТНОСТЬ",
        "Нюхач",
        "Путь самурая",
        "Son",
        "5"
    ]
}

