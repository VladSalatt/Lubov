//
//  Task.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 25.06.2022.
//

import Foundation

protocol TaskProtocol {
    var descriptionTask: String { get set }
}

struct Task: TaskProtocol {
    /// Описние задания
    var descriptionTask: String
}
