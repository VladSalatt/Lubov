//
//  SolomonTreasureViewController.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 07.07.2022.
//

import UIKit
import SwiftConfettiView

final class SolomonTreasureViewController: UIViewController {
    typealias SolomonStr = Strings.SolomonTreasure
    
    // MARK: - Views
    
    private let textInsetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .init(width: 3, height: 4)
        view.layer.shadowColor = UIColor.sandColor.cgColor
        view.backgroundColor = .sandColor
        return view
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkBlueColor
        label.font = .systemFont(ofSize: 18)
        label.text = SolomonStr.mainText
        label.numberOfLines = 0
        return label
    }()
    
    private let successButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle(SolomonStr.buttonTitle, for: .normal)
        bt.setTitleColor(.darkBlueColor, for: .normal)
        bt.setTitleColor(.lightBlueColor, for: .highlighted)
        bt.layer.cornerRadius = 10
        bt.layer.shadowOpacity = 0.3
        bt.layer.shadowOffset = .init(width: 3, height: 4)
        bt.layer.shadowColor = UIColor.successTaskColor.cgColor
        bt.backgroundColor = .successTaskColor
        return bt
    }()
    
    private lazy var confettiView: SwiftConfettiView = {
        let view = SwiftConfettiView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.type = .star
        view.intensity = 0.75
        view.isHidden = true
        return view
    }()
    
    // MARK: - Properties
    
    var presenter: SolomonTreasurePresenterProtocol?
    
    // MARK: - UIViewController Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .darkBlueColor

        view.addSubview(textInsetView)
        textInsetView.addSubview(textLabel)
        view.addSubview(successButton)
        
        successButton.addTarget(self, action: #selector(showQuestionAlert), for: .touchUpInside)
        
        view.addSubview(confettiView)
        
        NSLayoutConstraint.activate([
            textInsetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textInsetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textInsetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textLabel.topAnchor.constraint(equalTo: textInsetView.topAnchor, constant: 16),
            textLabel.leadingAnchor.constraint(equalTo: textInsetView.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: textInsetView.trailingAnchor, constant: -16),
            textLabel.bottomAnchor.constraint(equalTo: textInsetView.bottomAnchor, constant: -16),
            
            successButton.topAnchor.constraint(equalTo: textInsetView.bottomAnchor, constant: 16),
            successButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            successButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            successButton.heightAnchor.constraint(equalToConstant: 52),
            
            confettiView.topAnchor.constraint(equalTo: view.topAnchor),
            confettiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            confettiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confettiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc func showQuestionAlert() {
        let alertVC = AlertView(
            title: SolomonStr.QuestionAlert.title,
            message: SolomonStr.QuestionAlert.message,
            correctAnswer: SolomonStr.QuestionAlert.correctAnswer,
            checkAction: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success():
                    self.presenter?.saveTask(at: .solomonTreasure)
                    self.confettiView.isHidden = false
                    self.confettiView.startConfetti()
                    self.presenter?.playSound()
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
}

// MARK: - SolomonTreasurePresenter Delegate

extension SolomonTreasureViewController: SolomonTreasureViewProtocol {}
