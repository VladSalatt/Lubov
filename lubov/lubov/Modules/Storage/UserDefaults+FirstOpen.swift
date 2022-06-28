//
//  UserDefaults+FirstOpen.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 29.06.2022.
//

import Foundation

protocol TaskStorage {
    var isFirstOpen: Bool { get set }
}

extension UserDefaults {
    private static let isFirstOpen = "ru.lubov.is_first_open"
    
    var isFirstOpen: Bool {
        get {
            bool(forKey: Self.isFirstOpen)
        }
        set {
            set(newValue, forKey: Self.isFirstOpen)
        }
    }
}
