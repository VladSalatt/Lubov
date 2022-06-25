//
//  Task.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 25.06.2022.
//

import Foundation

struct Task {
    /// Номер задание
    var numberOfTask: Int
    /// Описние задания
    var descriptionTask: String
    
    /// Все модели заданий
    static let allTasks: [Task] = [
        .init(
            numberOfTask: 1,
            descriptionTask: "First Task"
        ),
        .init(
            numberOfTask: 2,
            descriptionTask: "Second Task"
        ),
        .init(
            numberOfTask: 3,
            descriptionTask: "Third Task"
        ),
        .init(
            numberOfTask: 4,
            descriptionTask: "Fourth Task"
        ),
        .init(
            numberOfTask: 5,
            descriptionTask: "Fifth Task"
        ),
        .init(
            numberOfTask: 6,
            descriptionTask: "Sixth Task"
        ),
    ]
}
