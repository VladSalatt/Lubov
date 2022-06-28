//
//  KnownBySquareViewOutput.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 26.06.2022.
//

import Foundation

protocol KnownBySquareViewOutput: AnyObject {
    init(view: KnownBySquareViewInput, router: KnownBySquareRouterProtocol)
    func addCoreMotion()
}
