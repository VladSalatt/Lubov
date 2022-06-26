//
//  KnownBySquareVC.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 26.06.2022.
//

import UIKit

final class KnownBySquareVC: UIViewController, KnownBySquareViewInput {

    // MARK: - properties
    
    var presenter: KnownBySquareViewOutput?

    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Узнаешь его по квадратности :-D"
        view.backgroundColor = .darkBlueColor
        // Do any additional setup after loading the view.
    }
    
}
