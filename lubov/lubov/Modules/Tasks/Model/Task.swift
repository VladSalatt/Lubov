//
//  Task.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 25.06.2022.
//

import Foundation

protocol TaskProtocol {
    var numberOfTask: Int { get set }
    var descriptionTask: String { get set }
}

struct Task: TaskProtocol {
    /// Номер задание
    var numberOfTask: Int
    /// Описние задания
    var descriptionTask: String
}
