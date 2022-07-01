//
//  KnownBySquareVC.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 26.06.2022.
//

import UIKit
import CoreMotion
import SwiftConfettiView

// TODO: Добавить сохранение в кор дату и обновление флага (isCompleted)
final class KnownBySquareVC: UIViewController, KnownBySquareViewInput {
    
    // MARK: - Properties

    private enum Constants {
        static let verticalInset: CGFloat = 50
        static let horizontalInset: CGFloat = 24
        static let toiletOpened: String = "toilet-opened"
        static let toiletHalfOpened: String = "toilet-half-opened"
        static let toiletClosed: String = "toilet-closed"
        static let squareSilent: String = "square-silent"
        static let squareTalk: String = "square-talk"
    }
    
    
    var presenter: KnownBySquareViewOutput?
    
    private var isToiletOpen: Bool = false
    private var squareCenterYConstraint: NSLayoutConstraint?
    private var squareOffset: CGFloat?
    
    // MARK: - Views
    
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
    
    private lazy var confettiView: SwiftConfettiView = {
        let view = SwiftConfettiView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.type = .star
        view.intensity = 0.75
        view.isHidden = true
        return view
    }()
    
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
        view.backgroundColor = .darkBlueColor
        view.addSubview(squareImageView)
        view.addSubview(toiletImageView)
        view.addSubview(confettiView)
        setupNavBar()
        makeConstraints()
    }
    
    func setupNavBar() {
        title = "Узнаешь его по квадратности :-D"
        navigationController?.setTitle(with: .sandColor)
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .bookmarks,
            target: self,
            action: #selector(showSimpleAlert)
        )
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

        //Confetti
        NSLayoutConstraint.activate([
            confettiView.topAnchor.constraint(equalTo: view.topAnchor),
            confettiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            confettiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confettiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
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
        showQuestionAlert()
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

// MARK: - UIAlert

private extension KnownBySquareVC {
    @objc func showSimpleAlert() {
        let alertVC = SimpleAlertview(
            title: "Задание",
            message: "Описание задания"
        )
        present(alertVC, animated: true)
    }
    
    func showQuestionAlert() {
        let alertVC = AlertView(
            title: "test",
            message: "test",
            correctAnswer: "test",
            checkAction: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success():
                    // TODO: Добавить сохранение в кор дату и обновление флага (isCompleted)
                    self.confettiView.isHidden = false
                    self.confettiView.startConfetti()
                    self.squareImageView.stopAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        guard self.confettiView.isActive() else { return }
                        self.confettiView.stopConfetti()
                        self.confettiView.isHidden = true
                    }
                case .failure(_):
                    break
                }
            },
            closeAction: { [weak self] in
                guard let self = self else { return }
                self.squareImageView.stopAnimating()
            }
        )
        present(alertVC, animated: true)
    }
}

