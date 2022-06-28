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
        static let bottomInset: CGFloat = 50
        static let topInset: CGFloat = bottomInset
    }
    
    // MARK: - properties
    
    var presenter: KnownBySquareViewOutput?
    
    private let toiletImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "toilet")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        
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
        addGesture()
    }
    
}

// MARK: - SetupUI

private extension KnownBySquareVC {
    
    func setupUI() {
        title = "Узнаешь его по квадратности :-D"
        view.backgroundColor = .darkBlueColor
        makeConstraints()
    }
    
    func makeConstraints() {
        // ToiletImage
        view.addSubview(toiletImageView)
        let toiletHeight = view.frame.height / 2 - (2 * Constants.bottomInset)
        NSLayoutConstraint.activate([
            toiletImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.bottomInset),
            toiletImageView.heightAnchor.constraint(equalToConstant: toiletHeight),
            toiletImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
    
}

// MARK: - TapGesture

private extension KnownBySquareVC {
    
    func addGesture() {
        let tap = UITapGestureRecognizer()
        
        toiletImageView.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(updateImage(touch:)))
    }
    
    @objc func updateImage(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: toiletImageView)
        let topEdge = toiletImageView.frame.height / 2 - 10
        let rightEdge = toiletImageView.frame.width / 3
        guard touchPoint.y >= topEdge || touchPoint.x <= rightEdge else { return }

        // UpdateImage
        print(touchPoint.x, touchPoint.y)
    }
    
}
