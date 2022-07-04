//
//  MemoryGameRouter.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 05.07.2022.
//

import UIKit

protocol MemoryGameRouterProtocol {
    init(view: UIViewController)
}

final class MemoryGameRouter: MemoryGameRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
}
