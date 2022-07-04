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
    
    func replaceCharacter(at index: Int, with: String) -> String {
        guard self.count - 1 >= index else { return "error" }
        var newText: String = ""
        
        for (n, c) in self.enumerated() {
            if n == index {
                newText.append(with)
            } else {
                newText.append(c)
            }
        }
        return newText
    }
}
