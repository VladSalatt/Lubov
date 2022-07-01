//
//  SimpleAlertview.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 01.07.2022.
//

import UIKit

/// Класс для показа текста с историей
final class SimpleAlertview: UIAlertController {
    convenience init(
        title: String?,
        message: String?
    ) {
        self.init(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "Понял принял обработал",
            style: .default
        )
        addAction(okAction)
    }
}
