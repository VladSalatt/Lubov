//
//  UserDefaults+FirstOpen.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 29.06.2022.
//

import Foundation

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
    // Initial names for tasks
    static let names: [String] = [
        "Узнаешь его по квадратности xD",
        "Парфюмер",
        "Кроссворд",
        "4",
        "5"
    ]
}
