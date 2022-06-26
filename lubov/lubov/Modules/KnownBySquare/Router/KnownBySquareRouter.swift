//
//  KnownBySquareRouter.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 26.06.2022.
//

import Foundation
import UIKit

final class KnownBySquareRouter: KnownBySquareRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}
