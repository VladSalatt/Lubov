//
//  BookCodeConfigurator.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 03.07.2022.
//

import UIKit

final class BookCodeConfigurator {
    static func configure() -> UIViewController {
        let view = BookCodeViewController()
        let router = BookCodeRouter(view: view)
        let presenter = BookCodePresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
    
}
