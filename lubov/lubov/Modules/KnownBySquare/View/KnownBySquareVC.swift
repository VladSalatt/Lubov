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
        static let verticalInset: CGFloat = 50
        static let horizontalInset: CGFloat = 24
        static let toiletOpened: String = "toilet-opened"
        static let toiletHalfOpened: String = "toilet-half-opened"
        static let toiletClosed: String = "toilet-closed"
    }
    
    // MARK: - properties
    
    var presenter: KnownBySquareViewOutput?
    
    private var isToiletOpen: Bool = false
    
    private let toiletImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.toiletClosed)
        imageView.animationDuration = 0.7
        imageView.animationRepeatCount = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.animationImages = [
            UIImage(named: Constants.toiletOpened)!,
            UIImage(named: Constants.toiletHalfOpened)!,
            UIImage(named: Constants.toiletClosed)!
        ]
        
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
        view.addSubview(toiletImageView)
        makeConstraints()
    }
    
    func makeConstraints() {
        // ToiletImage
        NSLayoutConstraint.activate([
            toiletImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.verticalInset),
            toiletImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 2 - (2 * Constants.verticalInset)),
            toiletImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
    
}

// MARK: - TapGesture

// For Toilet
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
        updateStateOfToilet()
    }
    
}

// For square
private extension KnownBySquareVC { }

// MARK: - Animations

private extension KnownBySquareVC {
    
    func updateStateOfToilet() {
        toiletImageView.animationImages?.swapAt(0, 2)
        toiletImageView.startAnimating()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.toiletImageView.image = self.toiletImageView.animationImages?.last!
        }
        isToiletOpen = !isToiletOpen
    }
    
}

