//
//  MemoryGameConfigurator.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 05.07.2022.
//

import UIKit

final class MemoryGameConfigurator {
    static func configure() -> UIViewController {
        let view = MemoryGameViewController()
        let router = MemoryGameRouter(view: view)
        let memoryGameLogic = MemoryGameLogic()
        let presenter = MemoryGamePresenter(
            view: view,
            router: router,
            memoryGameLogic: memoryGameLogic
        )
        view.presenter = presenter
        
        return view
    }
    
}
