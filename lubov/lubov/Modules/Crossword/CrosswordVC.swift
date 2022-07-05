//
//  CrosswordVC.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 04.07.2022.
//

import UIKit
import SwiftConfettiView

protocol CrosswordViewInput: AnyObject {
    
}

final class CrosswordVC: UIViewController, CrosswordViewInput {
    
    typealias CrosswordStr = Strings.Crossword
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 16
        static let lubaImage: String = "luba"
        static let imageOne: String = "inGlasses"
        static let imageTwo: String = "drink"
        static let imageThree: String = "coding"
    }
    // MARK: - Properties
    
    var presenter: CrosswordViewOutput?
    
    private var lubaLeadingConstraint: NSLayoutConstraint?
    
    private let lubaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.lubaImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.imageOne)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.imageTwo)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let thirdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.imageThree)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var waysStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 24
        return sv
    }()
    
    private let boxView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .init(width: 3, height: 4)
        view.layer.shadowColor = UIColor.landColor.cgColor
        view.backgroundColor = .landColor
        return view
    }()
    
    private let firstWayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.textColor = .darkBlueColor
        label.font = .boldSystemFont(ofSize: 24)
        label.text = "Путь 1"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let secondWayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.textColor = .darkBlueColor
        label.font = .boldSystemFont(ofSize: 24)
        label.text = "Путь 2"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let thirdWayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.textColor = .darkBlueColor
        label.font = .boldSystemFont(ofSize: 24)
        label.text = "Путь 3"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let answerButton: UIButton = {
        let button = UIButton()
        let textLabel = UILabel()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Я знаю ответ!", for: .normal)
        button.setTitleColor(.darkBlueColor, for: .normal)
        button.setTitleColor(.lightBlueColor, for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .init(width: 3, height: 4)
        button.layer.shadowColor = UIColor.successTaskColor.cgColor
        button.backgroundColor = .successTaskColor
        return button
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
        showSimpleAlert()
    }
    
}

// MARK: - SetupUI

private extension CrosswordVC {
    
    func setupUI() {
        view.backgroundColor = .darkBlueColor
        
        // Images
        view.addSubview(firstImageView)
        view.addSubview(secondImageView)
        view.addSubview(thirdImageView)
        view.addSubview(lubaImageView)
        
        // Ways
        view.addSubview(boxView)
        boxView.addSubview(waysStackView)
        waysStackView.addArrangedSubview(firstWayLabel)
        waysStackView.addArrangedSubview(secondWayLabel)
        waysStackView.addArrangedSubview(thirdWayLabel)
        
        // button
        view.addSubview(answerButton)
        
        // confetti
        view.addSubview(confettiView)
        
        setupNavBar()
        makeConstrains()
    }
    
    func setupNavBar() {
        title = CrosswordStr.cellTitle
        navigationController?.setTitle(with: .sandColor)
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .bookmarks,
            target: self,
            action: #selector(showSimpleAlert)
        )
    }
    
    func makeConstrains() {
        
        NSLayoutConstraint.activate([
            // BoxView
            boxView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/1.5),
            boxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boxView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.verticalInset),
            
            // WaysStackView
            waysStackView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: Constants.horizontalInset),
            waysStackView.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -Constants.horizontalInset),
            waysStackView.topAnchor.constraint(equalTo: boxView.topAnchor, constant: Constants.verticalInset),
            waysStackView.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: -Constants.verticalInset),
            
            // images
            firstImageView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor),
            firstImageView.widthAnchor.constraint(equalTo: boxView.widthAnchor, multiplier: 1/3.2),
            firstImageView.heightAnchor.constraint(equalTo: firstImageView.widthAnchor),
            firstImageView.topAnchor.constraint(equalTo: boxView.bottomAnchor, constant: Constants.verticalInset),
            
            secondImageView.centerXAnchor.constraint(equalTo: boxView.centerXAnchor),
            secondImageView.widthAnchor.constraint(equalTo: boxView.widthAnchor, multiplier: 1/3.2),
            secondImageView.heightAnchor.constraint(equalTo: secondImageView.widthAnchor),
            secondImageView.topAnchor.constraint(equalTo: boxView.bottomAnchor, constant: Constants.verticalInset),
            
            
            thirdImageView.trailingAnchor.constraint(equalTo: boxView.trailingAnchor),
            thirdImageView.widthAnchor.constraint(equalTo: boxView.widthAnchor, multiplier: 1/3.2),
            thirdImageView.heightAnchor.constraint(equalTo: thirdImageView.widthAnchor),
            thirdImageView.topAnchor.constraint(equalTo: boxView.bottomAnchor, constant: Constants.verticalInset),
            
            lubaImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            lubaImageView.heightAnchor.constraint(equalTo: lubaImageView.widthAnchor),
            lubaImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.verticalInset),
            
            // Answer Button
            answerButton.leadingAnchor.constraint(equalTo: boxView.leadingAnchor),
            answerButton.trailingAnchor.constraint(equalTo: boxView.trailingAnchor),
            answerButton.topAnchor.constraint(equalTo: firstImageView.bottomAnchor, constant: Constants.verticalInset),
            
            // confetti
            confettiView.topAnchor.constraint(equalTo: view.topAnchor),
            confettiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            confettiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confettiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        lubaLeadingConstraint = lubaImageView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.horizontalInset)
        lubaLeadingConstraint?.isActive = true
        
    }
    
    func addGesture() {
        let firstLabelTap = UITapGestureRecognizer()
        let secondLabelTap = UITapGestureRecognizer()
        let thirdLabelTap = UITapGestureRecognizer()
        let imageTap = UITapGestureRecognizer()
        
        firstWayLabel.addGestureRecognizer(firstLabelTap)
        secondWayLabel.addGestureRecognizer(secondLabelTap)
        thirdWayLabel.addGestureRecognizer(thirdLabelTap)
        secondImageView.addGestureRecognizer(imageTap)
        
        firstLabelTap.addTarget(self, action: #selector(getWayAlert(tap:)))
        secondLabelTap.addTarget(self, action: #selector(getWayAlert(tap:)))
        thirdLabelTap.addTarget(self, action: #selector(getWayAlert(tap:)))
        imageTap.addTarget(self, action: #selector(showLuba))
        answerButton.addTarget(self, action: #selector(showQuestionAlert), for: .touchUpInside)
    }
    
    
}

// MARK: - Alerts

private extension CrosswordVC {
    
    @objc func getWayAlert(tap: UITapGestureRecognizer) {
        guard let label = tap.view as? UILabel else { return }
        var newText = ""
        let alert = UIAlertController(
            title: "Какой путь?",
            message: "Этот? - \(label.text ?? "")",
            preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = label.text ?? ""
        }
        let doneAction = UIAlertAction(
            title: "Ввести",
            style: .default) { [weak alert, self] (_) in
                guard let textField = alert?.textFields?[0] else { return }
                newText = textField.text ?? ""
                self.updateTextLabel(of: label, with: newText)
            }
        let cancelAction = UIAlertAction(title: "Надо еще подумац", style: .cancel)
        alert.addAction(doneAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    func updateTextLabel(of label: UILabel, with newText: String) {
        var text = newText
        switch label {
        case firstWayLabel:
            text = text.replaceCharacter(at: 0, with: "_")
            text = text.replaceCharacter(at: 1, with: "_")
        case secondWayLabel:
            text = text.replaceCharacter(at: 0, with: "_")
        case thirdWayLabel:
            text = text.replaceCharacter(at: 3, with: "_")
        default:
            return
        }
        
        label.text = text
        
    }
    
    @objc func showSimpleAlert() {
        let alertVC = SimpleAlertview(
            title: CrosswordStr.SimpleAlert.title,
            message: CrosswordStr.SimpleAlert.message
        )
        present(alertVC, animated: true)
    }
    
    
    @objc func showQuestionAlert() {
        let alertVC = AlertView(
            title: CrosswordStr.QuestionAlert.title,
            message: CrosswordStr.QuestionAlert.message,
            correctAnswer: CrosswordStr.QuestionAlert.correctAnswer,
            checkAction: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success():
                    self.presenter?.saveTask(at: .crossword)
                    self.confettiView.isHidden = false
                    self.confettiView.startConfetti()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        guard self.confettiView.isActive() else { return }
                        self.confettiView.stopConfetti()
                        self.confettiView.isHidden = true
                    }
                default:
                    break
                }
            }
        )
        present(alertVC, animated: true)
    }
    
    @objc func showLuba() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard
                let self = self,
                let constraint = self.lubaLeadingConstraint,
                let presenter = self.presenter
            else { return }
            let offset = self.view.frame.width / 3 + Constants.horizontalInset + 1
            constraint.constant -= offset
            self.view.layoutIfNeeded()
            presenter.playSound()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                constraint.constant += offset
                self.view.layoutIfNeeded()
            }
        }
        
    }
}
