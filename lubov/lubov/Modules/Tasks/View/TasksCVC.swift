//
//  MainCollectionVC.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 31.05.2022.
//

import UIKit
import UIOnboarding

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
    var showOnboarding: Bool = false
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentOnboarding()
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
    
    func presentOnboarding() {
        guard showOnboarding else { return }
        let onboardingController: UIOnboardingViewController = .init(withConfiguration: .setUp())
        onboardingController.delegate = self
        navigationController?.present(onboardingController, animated: false)
    }
}

extension TasksCVC: UIOnboardingViewControllerDelegate {
    func didFinishOnboarding(onboardingViewController: UIOnboardingViewController) {
        onboardingViewController.modalTransitionStyle = .crossDissolve
        onboardingViewController.dismiss(animated: true)
    }
}

// MARK: - TasksViewInput

extension TasksCVC: TasksViewInput {
    var isFirstOpen: Bool {
        get { showOnboarding }
        set { showOnboarding = newValue }
    }
}
