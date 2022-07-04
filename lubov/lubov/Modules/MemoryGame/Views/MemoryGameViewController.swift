//
//  MemoryGameViewController.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 05.07.2022.
//

import UIKit

// TODO: Сделать кнопку для открытия алерта (25 str)
// TODO: Поиграться с размерами (58 str)
final class MemoryGameViewController: UIViewController {
    
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
    
    // MARK: - Properties
    
    var presenter: MemoryGamePresenterProtocol?
    
    // MARK: - UIViewController Events
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionFlowLayout()
        setupCollectionView()
        setupUI()
        makeConstraints()
    }
    
}

private extension MemoryGameViewController {
    func setupUI() {
        view.backgroundColor = .darkBlueColor
        view.addSubview(collectionView)
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
        ])
    }
}

// MARK: - MemoryGamePresenter Delegate

extension MemoryGameViewController: MemoryGameViewProtocol {}
