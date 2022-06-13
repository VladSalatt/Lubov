//
//  MainCollectionVC.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 31.05.2022.
//

import UIKit

// TODO: 1) Написать свой FlowLayout
// TODO: 2) Настроить динамическу высоту ячеек
// TODO: 3) Занести цветовую палитру
final class TasksCVC: UICollectionViewController {
    private enum Constants {
        static let collectionViewInsets: UIEdgeInsets = .init(
            top: 0,
            left: 24,
            bottom: 0,
            right: 24
        )
    }

    // MARK: - Properties
    
    var presenter: TasksViewOutput?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupUI()
    }
}

private extension TasksCVC {
    func setupCollectionView() {
        self.collectionView.register(
            TasksCellCollectionViewCell.self,
            forCellWithReuseIdentifier: TasksCellCollectionViewCell.reuseId
        )
        self.collectionView.delegate = presenter as? UICollectionViewDelegate
        self.collectionView.dataSource = presenter as? UICollectionViewDataSource
    }
    
    func setupUI() {
        title = "Tasks" // Переименовать
        self.collectionView.contentInset = Constants.collectionViewInsets
        self.collectionView.backgroundColor = .white // изменить
    }
}



// MARK: - TasksViewInput

extension TasksCVC: TasksViewInput {
    
}
