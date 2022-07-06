//
//  MemoryGameViewController.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 05.07.2022.
//

import UIKit
import SwiftConfettiView

final class MemoryGameViewController: UIViewController {
    typealias MemoryStr = Strings.MemoryGame
    
    // MARK: - Views
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .darkBlueColor
        return cv
    }()
    
    private let successButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle(MemoryStr.buttonTitle, for: .normal)
        bt.setTitleColor(.darkBlueColor, for: .normal)
        bt.setTitleColor(.lightBlueColor, for: .highlighted)
        bt.layer.cornerRadius = 10
        bt.layer.shadowOpacity = 0.3
        bt.layer.shadowOffset = .init(width: 3, height: 4)
        bt.layer.shadowColor = UIColor.successTaskColor.cgColor
        bt.backgroundColor = .successTaskColor
        bt.isHidden = true
        bt.alpha = 0
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
    
    var presenter: MemoryGamePresenterProtocol?
    
    // MARK: - UIViewController Events
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionFlowLayout()
        setupCollectionView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSimpleAlert()
    }
}

private extension MemoryGameViewController {
    func setupUI() {
        view.backgroundColor = .darkBlueColor
        view.addSubview(collectionView)
        view.addSubview(successButton)
        view.addSubview(confettiView)

        setupNavBar()
        setupSuccessButton()
        makeConstraints()
    }
    
    func setupSuccessButton() {
        guard let task = presenter?.fetchTask(at: .memoryGame) else {
            return
        }
        successButton.isHidden = task.isCompleted ? false : true
        successButton.alpha = task.isCompleted ? 1 : 0
        successButton.addTarget(self, action: #selector(showQuestionAlert), for: .touchUpInside)
    }
    
    func setupNavBar() {
        title = MemoryStr.cellTitle
        navigationController?.setTitle(with: .sandColor)
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .bookmarks,
            target: self,
            action: #selector(showSimpleAlert)
        )
    }
    
    @objc func showSimpleAlert() {
        let alertVC = SimpleAlertview(
            title: MemoryStr.SimpleAlert.title,
            message: MemoryStr.SimpleAlert.message
        )
        present(alertVC, animated: true)
    }
    
    func setupCollectionFlowLayout() {
        guard
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        else { return }
        layout.sectionInset = .init(top: 16, left: 24, bottom: 16, right: 24)
        layout.itemSize = .init(width: 69, height: 100)
        self.collectionView.collectionViewLayout = layout
    }
    
    func setupCollectionView() {
        self.collectionView.register(MemoryCardCell.self, forCellWithReuseIdentifier: MemoryCardCell.reuseId)
        self.collectionView.delegate = presenter as? UICollectionViewDelegate
        self.collectionView.dataSource = presenter as? UICollectionViewDataSource
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            successButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            successButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            successButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            successButton.heightAnchor.constraint(equalToConstant: 52),
            
            // confetti
            confettiView.topAnchor.constraint(equalTo: view.topAnchor),
            confettiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            confettiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confettiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - MemoryGamePresenter Delegate

extension MemoryGameViewController: MemoryGameViewProtocol {
    func successActions() {
        UIView.animate(
            withDuration: 3,
            delay: 0.5,
            options: [.curveEaseOut],
            animations: { [weak self] in
                guard let self = self, self.successButton.isHidden else { return }
                self.successButton.alpha = 1
                self.successButton.isHidden = false
            })
    }
    
    @objc func showQuestionAlert() {
        let alertVC = AlertView(
            title: MemoryStr.QuestionAlert.title,
            message: MemoryStr.QuestionAlert.message,
            correctAnswer: MemoryStr.QuestionAlert.correctAnswer,
            checkAction: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success():
                    self.presenter?.saveTask(at: .memoryGame)
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
