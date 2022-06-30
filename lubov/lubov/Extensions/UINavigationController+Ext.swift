//
//  UINavigationController+Ext.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 30.06.2022.
//

import UIKit

extension UINavigationController {
    func setTitle(with color: UIColor) {
        navigationBar.titleTextAttributes = [.foregroundColor: color]
   }
}
