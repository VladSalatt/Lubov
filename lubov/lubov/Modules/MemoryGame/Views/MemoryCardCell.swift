//
//  MemoryCardCell.swift
//  lubov
//
//  Created by VKoshelev@detmir.ru on 05.07.2022.
//

import UIKit

class MemoryCardCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseId = "memoryCardCellId"
    
    // MARK: - Views
    
    private var cardBackImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private var cardFrontImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
    }
    
    func configure(with model: Model) {
        cardBackImage.image = model.backImage
        cardFrontImage.image = model.frontImage
        
        updateVisibility(model.isMatched)
    }
}

extension MemoryCardCell {
    struct Model {
        let backImage: UIImage
        let frontImage: UIImage
        let isMatched: Bool
    }
}

// MARK: - Public Methods

extension MemoryCardCell {
    /// Flips the cell from back to front
    func flip() {
        cardFrontImage.alpha = 1
        UIView.transition(
            from: cardBackImage,
            to: cardFrontImage,
            duration: 0.2,
            options: [.transitionFlipFromLeft, .showHideTransitionViews])
    }
    
    /// Flips the cell from front to back
    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            UIView.transition(
                from: self.cardFrontImage,
                to: self.cardBackImage,
                duration: 0.2,
                options: [.transitionFlipFromRight, .showHideTransitionViews])
        }
    }
    
    /// Flips the cell from front to back in 0.01 seconds
    func flipBackImmediately() {
        UIView.transition(
            from: cardFrontImage,
            to: cardBackImage,
            duration: 0.01,
            options: [.transitionFlipFromRight, .showHideTransitionViews])
    }
    
    func remove() {
        cardBackImage.alpha = 0
        UIView.animate(
            withDuration: 0.2,
            delay: 0.5,
            options: .curveEaseOut,
            animations: { [weak self] in
                guard let self = self else { return }
                self.cardFrontImage.alpha = 0
            }
        )
    }
}

// MARK: - Private Methods

private extension MemoryCardCell {
    func setupUI() {
        contentView.addSubview(cardFrontImage)
        contentView.addSubview(cardBackImage)
        clipsToBounds = true
    }

    func makeConstraints() {
        NSLayoutConstraint.activate([
            cardBackImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardBackImage.topAnchor.constraint(equalTo: topAnchor),
            cardBackImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardBackImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cardFrontImage.leadingAnchor.constraint(equalTo: cardBackImage.leadingAnchor),
            cardFrontImage.topAnchor.constraint(equalTo: cardBackImage.topAnchor),
            cardFrontImage.trailingAnchor.constraint(equalTo: cardBackImage.trailingAnchor),
            cardFrontImage.bottomAnchor.constraint(equalTo: cardBackImage.bottomAnchor),
        ])
        
        cardFrontImage.alpha = 0
    }
    
    func updateVisibility(_ isMatched: Bool) {
        cardBackImage.alpha = isMatched ? 0 : 1
        cardFrontImage.alpha = 0
        flipBackImmediately()
    }
}
