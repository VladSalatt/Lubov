//
//  SolomonTreasureRouter.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 07.07.2022.
//

import UIKit

protocol SolomonTreasureRouterProtocol {
    init(view: UIViewController)
}

final class SolomonTreasureRouter: SolomonTreasureRouterProtocol {
    
    // MARK: - Properties
    
    private weak var view: UIViewController?
    
    // MARK: - Initializers
    
    init(view: UIViewController) {
        self.view = view
    }
    
}
