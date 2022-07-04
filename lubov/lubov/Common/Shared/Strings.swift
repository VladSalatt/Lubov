//
//  Strings.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 03.07.2022.
//
import Foundation

/// Тут будут все текста для заданий, в том числе и правильные ответы
enum Strings {
    /// Второе задание, с кодом из книги
    enum BookCode {
        static let cellTitle: String = "Парфюмер"
        enum Main {
            static let quote: String = "Тут будут очень длинный тест с цитатами и тп"
            static let author: String = "М.О Бальзак"
            static let code: String = "123 345 482 442 3"
            static let description: String = "Тыры пыры тым тым тым. Может сюда вырезку из Парфюмера вставить"
        }
        enum SimpleAlert {
            static let title: String = "Описание 2"
            static let message: String = "Описание 2"
        }
        enum QuestionAlert {
            static let title: String = "Задание 2"
            static let message: String = "Задание 2"
            static let correctAnswer: String = "test"
        }
    }
    
    enum Crossword {
        static let cellTitle: String = "Кроссворд"
        enum SimpleAlert {
            static let title: String = "Описание 3"
            static let message: String = "Описание 3"
        }
        enum QuestionAlert {
            static let title: String = "Задание 3"
            static let message: String = "Задание 3"
            static let correctAnswer: String = "узел"
        }
    }
}
