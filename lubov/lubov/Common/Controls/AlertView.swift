//
//  AlertView.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 30.06.2022.
//

import UIKit

final class AlertView: UIAlertController {
    private lazy var localTextField = UITextField()
    private var correctAnswer: String = ""
    
    convenience init(
        title: String,
        message: String,
        correctAnswer: String,
        checkAction: @escaping ((Result<Void, Error>) -> Void),
        closeAction: (() -> Void)? = nil
    ) {
        self.init(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        self.correctAnswer = correctAnswer
        
        addTextField { [weak self] textField in
            guard let self = self else { return }
            textField.placeholder = "Ответ сюда"
            textField.addTarget(
                self,
                action: #selector(self.textFieldDidChange(field:)),
                for: .editingChanged
            )
            self.localTextField = textField
        }
        
        let closeAction = UIAlertAction(
            title: "СДАЮСЬ!!!",
            style: .destructive,
            handler: { _ in
                guard let closeAction = closeAction else { return }
                closeAction()
            }
        )
        let checkAction: UIAlertAction = {
            let action = UIAlertAction(
                title: "ПроверОЧКА",
                style: .default,
                handler: { _ in
                    checkAction(.success(()))
                }
            )
            action.isEnabled = false
            return action
        }()
        addAction(closeAction)
        addAction(checkAction)
    }
}

private extension AlertView {
    func validate(
        _ text: String?,
        _ correctAnswer: String
    ) -> Result<Void, ValidateError> {
        guard
            let text = text?.trimmed.lowercased(),
            !text.isEmpty
        else { return .failure(.emptyInput) }
        return text == correctAnswer.trimmed.lowercased()
            ? .success(())
            : .failure(.incorrectAnswer)
    }
    
    @objc func textFieldDidChange(field: UITextField) {
        let checkAction = actions[1]
        let result = validate(localTextField.text, correctAnswer)
        switch result {
        case .success():
            checkAction.isEnabled = true
        case .failure(_):
            checkAction.isEnabled = false
        }
    }
}
