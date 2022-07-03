//
//  TasksCellCollectionViewCell.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 09.06.2022.
//

import UIKit

final class TasksCellCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseId = "tasksCellId"
    
    private enum Constants {
        static let horizontalInset: CGFloat = 10
        static let verticalInset: CGFloat = 10
        static let insetOfCellFromSuperview: CGFloat = 24
    }
    
    // MARK: - Views
    
    private lazy var titleTaskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .darkBlueColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var style: Style = .normal {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCylce
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Со всеми этими значениями можно поиграться и выбрать лучший вариант
        layer.cornerRadius = 10 // Изменить радиус после написание лейаута
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .init(width: 3, height: 4)
    }
    
    /// Метод, который конфигурирует ячейку, все данные в ячейку передаем ТОЛЬКО ЧЕРЕЗ НЕГО
    /// Иными словами во вне мы будем вызывать только его
    func configure(with model: Model) {
        titleTaskLabel.setTextOrHide(model.descriptionOfTask)
        style = model.style
        isHidden = model.isHidden
    }
    
    // Эта херня отвечает за динамическую высоту ячейки и распределению ее по всей длине экрана
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let width = UIScreen.main.bounds.size.width - Constants.insetOfCellFromSuperview * 2
        layoutAttributes.bounds.size.width = width
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + 50
        return layoutAttributes
    }
    
}

// MARK: - Model

extension TasksCellCollectionViewCell {
    /// Модель данных, которая приходит извне. И после конфигурирует ячейку
    struct Model {
        let descriptionOfTask: String?
        let style: Style
        let isHidden: Bool
    }
    
    /// Стили ячеек
    enum Style {
        case normal
        case success
    }
}

// MARK: - Setup UI

private extension TasksCellCollectionViewCell {
    func setupUI() {
        backgroundColor = .sandColor
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        contentView.addSubview(titleTaskLabel)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            // contentView
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalInset),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalInset),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalInset),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalInset),
            
            // titleTaskLabel
            titleTaskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleTaskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleTaskLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleTaskLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func updateUI() {
        switch style {
        case .normal:
            backgroundColor = .sandColor
        case .success:
            backgroundColor = .darkGreenColor
        }
    }
}
