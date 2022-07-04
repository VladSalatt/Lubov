//
//  MainCollectionVC.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 31.05.2022.
//

import UIKit

final class TasksCVC: UICollectionViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let collectionViewInsets: UIEdgeInsets = .init(
            top: 0,
            left: horizontalInset,
            bottom: 0,
            right: horizontalInset
        )
        static let horizontalInset: CGFloat = 24
        static let minimumLineSpacing: CGFloat = 20
    }

    // MARK: - Properties
    
    var presenter: TasksViewOutput?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionFlowLayout()
        setupCollectionView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}

private extension TasksCVC {
    func setupCollectionFlowLayout() {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = Constants.collectionViewInsets
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        self.collectionView.collectionViewLayout = layout
    }
    
    func setupCollectionView() {
        self.collectionView.register(
            TasksCellCollectionViewCell.self,
            forCellWithReuseIdentifier: TasksCellCollectionViewCell.reuseId
        )
        self.collectionView.delegate = presenter as? UICollectionViewDelegate
        self.collectionView.dataSource = presenter as? UICollectionViewDataSource
    }
    
    func setupUI() {
        self.collectionView.backgroundColor = .darkBlueColor
    }
}



// MARK: - TasksViewInput

extension TasksCVC: TasksViewInput {
    
}
