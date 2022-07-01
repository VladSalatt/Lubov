//
//  String.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 29.06.2022.
//

import UIKit

extension UILabel {
    func setTextOrHide(_ text: String?) {
        self.text = text
        isHidden = text == nil || text == ""
    }
}

