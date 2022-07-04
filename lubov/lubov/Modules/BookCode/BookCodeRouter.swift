//
//  BookCodeRouter.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 03.07.2022.
//

import UIKit

protocol BookCodeRouterProtocol {
    init(view: UIViewController)
}

final class BookCodeRouter: BookCodeRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
}
