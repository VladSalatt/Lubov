//
//  SolomonTreasureConfigurator.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 07.07.2022.
//

import UIKit

final class SolomonTreasureConfigurator {
    static func configure() -> UIViewController {
        let view = SolomonTreasureViewController()
        let router = SolomonTreasureRouter(view: view)
        let presenter = SolomonTreasurePresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
    
}
