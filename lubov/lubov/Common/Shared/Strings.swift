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
            static let title: String = "Тиберий Клавдий Цезарь IV говорил: "
            static let message: String = "ррр хчуымо"
            static let correctAnswer: String = "ммм супчик"
        }
    }
    
    /// Второе задание, с кодом из книги
    enum BookCode {
        static let cellTitle: String = "Нюхач"
        enum Main {
            static let quote: String = "Нет такой человеческой фантазии, которую бы реальность не превзошла играючи."
            static let author: String = "- Патрик Зюскинд"
            static let code: String = "516 8148 11102 5181 7106 971 7"
        }
        enum SimpleAlert {
            static let title: String = "Единственная истина"
            static let message: String = "В аромате есть убедительность, которая сильнее слов, очевидности, чувства и воли. Убедительность аромата неопровержима, необорима, она входит в нас подобно тому, как входит в наши лёгкие воздух, которым мы дышим, она наполняет, заполняет нас до отказа. Против неё нет средства."
        }
        enum QuestionAlert {
            static let title: String = "Рад что ты поняла, как меня найти :)"
            static let message: String = "Теперь желанное тобой на первом месте. Ой, на нулевом"
            static let correctAnswer: String = "аромат"
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
            static let message: String = "Г ОДФЦД"
            static let correctAnswer: String = "Я КАРТА"
        }
    }
    
    enum SolomonTreasure {
        static let cellTitle: String = "Сокровище царя Соломона"
        static let buttonTitle: String = "Попробуй и ты!"
        static let mainText: String = "\tВ Священном писании существует один библейский персонаж, который окутан целым шлейфом мифов и легенд. Его образ считается неотъемлемым для иудейской, христианской и исламской религий, а его мудрость и справедливость воспевались целыми поколениями литераторов и поэтов. Имя ему царь Соломон.\n\tПо библейским источникам он выступает в качестве мудрейшего из людей, справедливого судьи, умевшего найти оригинальное решение в самых необыкновенных ситуациях.\n\tНемногие знают, что царь собрал самые ценные богатсва этого мира и спрятал их в потаенной месте. Из-за этого в конце жизни его пытались поймать и казнить целых 7 раз. Говоря свои последние слова царь заискался, но все же признался, где их искать.\n\tЭнтузиасты всего мира того времени отправились на поиски сокровищ, но никто ничего не нашел...Получается Соломон всех обманул? Или нет?"
        enum QuestionAlert {
            static let title: String = "Последними словами Соломона были:"
            static let message: String = "ннннннннннннннннннннннннннаааааааааааааааааааааа дддддддддддддддддддддддддннннннеееееееееее"
            static let correctAnswer: String = "не ебу"
        }
    }
}
