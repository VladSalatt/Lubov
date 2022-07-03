//
//  String+Ext.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 01.07.2022.
//

import Foundation

extension String {
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
