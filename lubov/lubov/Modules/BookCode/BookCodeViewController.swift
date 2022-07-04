//
//  BookCodeViewController.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 03.07.2022.
//

import UIKit
import SwiftConfettiView

final class BookCodeViewController: UIViewController {
    typealias BookCodeStr = Strings.BookCode
    private enum K {
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 16
    }
    
    // MARK: - Properties
    
    private let quoteInsetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .init(width: 3, height: 4)
        view.layer.shadowColor = UIColor.sandColor.cgColor
        view.backgroundColor = .sandColor
        return view
    }()
    
    /// Цитатка АУУУФФФФ
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkBlueColor
        label.font = .italicSystemFont(ofSize: 18)
        label.text = BookCodeStr.Main.quote
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkBlueColor
        label.font = .italicSystemFont(ofSize: 18)
        label.text = BookCodeStr.Main.author
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var quoteStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()
    
    private let codeInsetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .init(width: 3, height: 4)
        view.layer.shadowColor = UIColor.landColor.cgColor
        view.backgroundColor = .landColor
        return view
    }()
    
    /// Здесь собсна будет сам код
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkBlueColor
        label.font = .boldSystemFont(ofSize: 24)
        label.text = BookCodeStr.Main.code
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionInsetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .init(width: 3, height: 4)
        view.layer.shadowColor = UIColor.landColor.cgColor
        view.backgroundColor = .landColor
        return view
    }()
    
    /// Сюда положу текст из книги, чтобы понятнее было
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkBlueColor
        label.font = .systemFont(ofSize: 24)
        label.text = BookCodeStr.Main.description
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var confettiView: SwiftConfettiView = {
        let view = SwiftConfettiView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.type = .star
        view.intensity = 0.75
        view.isHidden = true
        return view
    }()
    
    var presenter: BookCodePresenterProtocol?
    
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

private extension BookCodeViewController {
    func setupUI() {
        view.backgroundColor = .darkBlueColor
        // Quote
        view.addSubview(quoteInsetView)
        quoteInsetView.addSubview(quoteStackView)
        quoteStackView.addArrangedSubview(quoteLabel)
        quoteStackView.addArrangedSubview(authorLabel)
        
        // Code
        view.addSubview(codeInsetView)
        codeInsetView.addSubview(codeLabel)
        
        // Description
        view.addSubview(descriptionInsetView)
        descriptionInsetView.addSubview(descriptionLabel)
        
        // Confetti
        view.addSubview(confettiView)
        
        setupNavBar()
        makeConstraints()
    }
    
    func setupNavBar() {
        title = BookCodeStr.cellTitle
        navigationController?.setTitle(with: .sandColor)
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .bookmarks,
            target: self,
            action: #selector(showSimpleAlert)
        )
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            // quoteInsetView
            quoteInsetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: K.verticalInset),
            quoteInsetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: K.horizontalInset),
            quoteInsetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -K.horizontalInset),
            
            // quoteStackView
            quoteStackView.topAnchor.constraint(equalTo: quoteInsetView.topAnchor, constant: K.verticalInset),
            quoteStackView.bottomAnchor.constraint(equalTo: quoteInsetView.bottomAnchor, constant: -K.verticalInset),
            quoteStackView.leadingAnchor.constraint(equalTo: quoteInsetView.leadingAnchor, constant: K.horizontalInset),
            quoteStackView.trailingAnchor.constraint(equalTo: quoteInsetView.trailingAnchor, constant: -K.horizontalInset),
            
            // codeInsetView
            codeInsetView.topAnchor.constraint(equalTo: quoteInsetView.bottomAnchor, constant: K.verticalInset),
            codeInsetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: K.horizontalInset),
            codeInsetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -K.horizontalInset),
            
            // codeLabel
            codeLabel.topAnchor.constraint(equalTo: codeInsetView.topAnchor, constant: K.verticalInset),
            codeLabel.leadingAnchor.constraint(equalTo: codeInsetView.leadingAnchor, constant: K.horizontalInset),
            codeLabel.trailingAnchor.constraint(equalTo: codeInsetView.trailingAnchor, constant: -K.horizontalInset),
            codeLabel.bottomAnchor.constraint(equalTo: codeInsetView.bottomAnchor, constant: -K.verticalInset),
            
            // descriptionInsetView
            descriptionInsetView.topAnchor.constraint(equalTo: codeInsetView.bottomAnchor, constant: K.verticalInset),
            descriptionInsetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: K.horizontalInset),
            descriptionInsetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -K.horizontalInset),
            
            // descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: descriptionInsetView.topAnchor, constant: K.verticalInset),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionInsetView.leadingAnchor, constant: K.horizontalInset),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionInsetView.trailingAnchor, constant: -K.horizontalInset),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionInsetView.bottomAnchor, constant: -K.verticalInset),
            
            // confetti
            confettiView.topAnchor.constraint(equalTo: view.topAnchor),
            confettiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            confettiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confettiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func addGesture() {
        let quoteTap = UITapGestureRecognizer()
        quoteInsetView.addGestureRecognizer(quoteTap)
        quoteTap.addTarget(self, action: #selector(showQuestionAlert))
    }
}

// MARK: - Alerts

private extension BookCodeViewController {
    @objc func showSimpleAlert() {
        let alertVC = SimpleAlertview(
            title: BookCodeStr.SimpleAlert.title,
            message: BookCodeStr.SimpleAlert.message
        )
        present(alertVC, animated: true)
    }
    
    @objc func showQuestionAlert() {
        let alertVC = AlertView(
            title: BookCodeStr.QuestionAlert.title,
            message: BookCodeStr.QuestionAlert.message,
            correctAnswer: BookCodeStr.QuestionAlert.correctAnswer,
            checkAction: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success():
                    self.presenter?.saveTask(at: .bookCode)
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
}

// MARK: - BookCodePresenter Delegate

extension BookCodeViewController: BookCodeViewProtocol {}
