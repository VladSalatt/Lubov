//
//  Strings.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 03.07.2022.
//

import Foundation

/// Тут будут все текста для заданий, в том числе и правильные ответы
enum Strings {
    /// Первое задание
    enum KnownBySquare {
        static let cellTitle: String = "Имя им - КВАДРАТНОСТЬ"
        enum SimpleAlert {
            static let title: String = "Имя им - КВАДРАТНОСТЬ"
            static let message: String = "Ходят слухи, что в Александрийской библиотеке нашли мемуары одного Римского императора - Тиберия. Он стал известен тем, что смотрел на все вещи с различных сторон. Изучив рукописи, можно наткнутся на интересную фразу, которую говорил Тиберий во время приема пищи"
        }
        enum QuestionAlert {
            // Тиберий Клавдий Цезарь говорит “lxxt>33m2mqkyv2gsq3q=w]O2ntk”
            static let title: String = "Тиберий Клавдий Цезарь IV говорил: "
            static let message: String = "ммм супчик"
            static let correctAnswer: String = "ммм супчик"
        }
    }
    
    /// Второе задание, с кодом из книги
    enum BookCode {
        static let cellTitle: String = "Нюхач"
        enum Main {
            static let quote: String = "Тут будут очень длинный тест с цитатами и тп"
            static let author: String = "М.О Бальзак"
            static let code: String = "123 345 482 442 9"
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
    
    /// Третье задание
    enum Crossword {
        static let cellTitle: String = "Путь самурая"
        static let toastySound: String = "toastySound"
        static let answerButtonTitle: String = "Я знаю ответ!"
        enum SimpleAlert {
            static let title: String = "Хокку, чтобы не было скучно"
            static let message: String = "Я прилег в тени панельки,\nЗа меня толчет мои пельменьки\n Российский мясокомбинат"
        }
        enum QuestionAlert {
            static let title: String = "Так так так"
            static let message: String = "Чем ты соединишь эти пути?"
            static let correctAnswer: String = "узел"
        }
        enum GetWayAlert {
            static let title: String = "Какой путь?"
            static let message: String = "Этот "
            static let doneActionTitle: String = "Ввести"
            static let cancelActionTitle: String = "Надо еще подумац"
        }
    }
    
    /// Четвертое задание, memoryGame
    enum MemoryGame {
        static let cellTitle: String = "Son"
        static let buttonTitle: String = "Уже готово!"
        enum SimpleAlert {
            static let title: String = "Son это не тот кто сын, а тот, кто спит"
            static let message: String = "Помнишь тебе снилось, что ты была то функцией, то фракталом, то цилиндром? Молодец, что помнишь"
        }
        enum QuestionAlert {
            static let title: String = "Так вот, теперь тебе надо представить себя не собой. Так кто ты?"
            static let message: String = "Я КАРТА"
            static let correctAnswer: String = "Я КАРТА"
        }
    }
}
