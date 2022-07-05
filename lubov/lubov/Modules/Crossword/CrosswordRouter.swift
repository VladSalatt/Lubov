//
//  CrosswordRouter.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 04.07.2022.
//

import UIKit

protocol CrosswordRouterProtocol {
    init(view: UIViewController)
}

final class CrosswordRouter: CrosswordRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
}
