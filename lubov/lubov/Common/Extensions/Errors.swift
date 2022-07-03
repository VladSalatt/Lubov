//
//  Errors.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 01.07.2022.
//

import Foundation

enum ValidateError: Error {
    case emptyInput
    case incorrectAnswer
    
    var localizedValidateError: String {
        switch self {
        case .emptyInput:
            return "ПУСТО"
        case .incorrectAnswer:
            return "МИМО, Попробуй еще раз"
        }
    }
}
