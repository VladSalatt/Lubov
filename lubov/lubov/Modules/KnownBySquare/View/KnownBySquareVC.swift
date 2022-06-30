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
        static let squareSilent: String = "square-silent"
        static let squareTalk: String = "square-talk"
    }
    
    // MARK: - properties
    
    var presenter: KnownBySquareViewOutput?
    
    private var isToiletOpen: Bool = false
    
    private let toiletImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.toiletClosed)
        imageView.animationDuration = 0.6
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
    
    private let squareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.squareSilent)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.animationDuration = 0.6
        imageView.animationRepeatCount = 0
        imageView.animationImages = [
            UIImage(named: Constants.squareSilent)!,
            UIImage(named: Constants.squareTalk)!
        ]
        
        return imageView
    }()
    
    private var squareCenterYConstraint: NSLayoutConstraint?
    private var squareOffset: CGFloat?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.addCoreMotion()
    }
    
}

// MARK: - SetupUI

private extension KnownBySquareVC {
    
    func setupUI() {
        title = "Узнаешь его по квадратности :-D"
        navigationController?.setTitle(with: .sandColor)
        view.backgroundColor = .darkBlueColor
        view.addSubview(squareImageView)
        view.addSubview(toiletImageView)
        makeConstraints()
    }
    
    func makeConstraints() {
        // ToiletImage
        // рассчет высоты туалета
        let toileghtHeight = view.frame.height / 2 - (2 * Constants.verticalInset)
        NSLayoutConstraint.activate([
            toiletImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.verticalInset),
            toiletImageView.heightAnchor.constraint(equalToConstant: toileghtHeight),
            toiletImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // SquareImage
        NSLayoutConstraint.activate([
            squareImageView.heightAnchor.constraint(equalTo: toiletImageView.heightAnchor, multiplier: 1/4),
            squareImageView.widthAnchor.constraint(equalTo: squareImageView.heightAnchor),
            squareImageView.centerXAnchor.constraint(equalTo: toiletImageView.centerXAnchor),
            
        ])
        squareCenterYConstraint = squareImageView.centerYAnchor.constraint(equalTo: toiletImageView.centerYAnchor, constant: Constants.verticalInset + 2)
        squareCenterYConstraint?.isActive = true
        // Рассчет смещения для анимации квадратика
        squareOffset = view.frame.height - toileghtHeight - view.safeAreaInsets.top
        
    }
    
}

// MARK: - TapGesture

// For Toilet
private extension KnownBySquareVC {
    
    func addGesture() {
        let toiletTap = UITapGestureRecognizer()
        let squareTap = UITapGestureRecognizer()
        
        toiletImageView.addGestureRecognizer(toiletTap)
        squareImageView.addGestureRecognizer(squareTap)
        toiletTap.addTarget(self, action: #selector(updateToiletImage(touch:)))
        squareTap.addTarget(self, action: #selector(updateSquareImage))
    }
    
    @objc func updateToiletImage(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: toiletImageView)
        let topEdge = toiletImageView.frame.height / 2 - 10
        let rightEdge = toiletImageView.frame.width / 3
        guard touchPoint.y >= topEdge || touchPoint.x <= rightEdge else { return }
        
        // UpdateImage
        updateStateOfToilet()
    }
    
    
    
}

// MARK: - Animations

extension KnownBySquareVC {
    
    func updateStateOfToilet() {
        toiletImageView.animationImages?.swapAt(0, 2)
        toiletImageView.startAnimating()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.toiletImageView.image = self.toiletImageView.animationImages?.last!
        }
        isToiletOpen = !isToiletOpen
    }
     
    @objc func updateSquareImage() {
        squareImageView.startAnimating()
        let alertVC = UIAlertController(
            title: "Answer",
            message: "Клаудий юрий цезарь говорил: хуй",
            preferredStyle: .alert
        )

        let closeAction = UIAlertAction(
            title: "Закрыть",
            style: .cancel) { [weak self] _ in
                self?.squareImageView.stopAnimating()
            }

        let checkAction = UIAlertAction(
            title: "Проверить",
            style: .default,
            // Проверять
            handler: nil
        )

        alertVC.addAction(closeAction)
        alertVC.addAction(checkAction)
        present(alertVC, animated: true)
        
    }
   
    func animateSquare() {
        // Если квадрат виден, на него можно нажать
        guard isToiletOpen else { return }
        squareImageView.isUserInteractionEnabled = true
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard
                let self = self,
                let constraint = self.squareCenterYConstraint,
                let offset = self.squareOffset
            else { return }
            constraint.constant -= offset
            self.squareOffset = 0
            self.view.layoutIfNeeded()
        }
    }
    
}

