//
//  CrosswordConfigurator.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 04.07.2022.
//

import UIKit

final class CrosswordConfigurator {
    static func configure() -> UIViewController {
        let view = CrosswordVC()
        let router = CrosswordRouter(view: view)
        let presenter = CrosswordPresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
}
