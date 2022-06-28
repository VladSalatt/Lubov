//
//  KnownBySquareVC.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 26.06.2022.
//

import UIKit
import CoreMotion

final class KnownBySquareVC: UIViewController, KnownBySquareViewInput {
    
    // MARK: - Constants
    
    private enum Constants {
        static let topInset: CGFloat = 24
        static let bottomInset: CGFloat = 50
    }
    
    // MARK: - properties
    
    var presenter: KnownBySquareViewOutput?
    
    private let toiletImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "toilet")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.addCoreMotion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

private extension KnownBySquareVC {
    
    func setupUI() {
        title = "Узнаешь его по квадратности :-D"
        view.backgroundColor = .darkBlueColor
        makeConstraints()
    }
    
    func makeConstraints() {
        // ToiletImage
        view.addSubview(toiletImageView)
        NSLayoutConstraint.activate([
            toiletImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.bottomInset),
            toiletImageView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.topInset),
            toiletImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
    
}
