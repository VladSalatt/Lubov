//
//  KnownBySquarePresenter.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 26.06.2022.
//

import Foundation

final class KnownBySquarePresenter: NSObject, KnownBySquareViewOutput {
    
    // MARK: - Properties
    
    private weak var view: KnownBySquareViewInput?
    private weak var router: KnownBySquareRouterProtocol?
    
    init(view: KnownBySquareViewInput, router: KnownBySquareRouterProtocol) {
        self.view = view
        self.router = router
    }
 
}
