//
//  TasksCellCollectionViewCell.swift
//  lubov
//
//  Created by Ramazan Abdulaev on 09.06.2022.
//

import UIKit

final class TasksCellCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private enum Constants {
        static let horizontalInset: CGFloat = 10
        static let verticalInset: CGFloat = 10
        static let insetOfCellFromSuperview: CGFloat = 24
    }
    
    /// Проперти по которому потом будем определять номер задания
    /// `private(set)` - это доступ, при котором
    /// мы можем получить значение откуда угодно `get`
    /// но засетить мы сможем его только в этом файле `set`
    private(set) var numberOfTask: Int?
    static let reuseId = "tasksCellId"

    // MARK: - Views
    
    private lazy var numberOfTaskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var titleTaskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Test Task"
        label.textColor = .white
        return label
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
        // Со всеми этими значениями можно поиграться и выбрать лучший вариант
        layer.cornerRadius = 10 // Изменить радиус после написание лейаута
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .init(width: 3, height: 4)
    }
    
    /// Метод, который конфигурирует ячейку, все данные в ячейку передаем ТОЛЬКО ЧЕРЕЗ НЕГО
    /// Иными словами во вне мы будем вызывать только его
    func configure(_ model: Model) {
        self.numberOfTask = model.numberOfTask + 1
        numberOfTaskLabel.text = (model.numberOfTask + 1).stringValue
    }
    
    // Эта херня отвечает за динамическую высоту ячейки и распределению ее по всей длине экрана
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let width = UIScreen.main.bounds.size.width - Constants.insetOfCellFromSuperview * 2
        layoutAttributes.bounds.size.width = width
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
}

extension TasksCellCollectionViewCell {
    /// Модель данных, которая приходит извне. И после конфигурирует ячейку
    struct Model {
        let numberOfTask: Int
    }
}

private extension TasksCellCollectionViewCell {
    func setupUI() {
        backgroundColor = .red // Изменить
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        contentView.addSubview(numberOfTaskLabel)
        contentView.addSubview(titleTaskLabel)
        
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            // contentView
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalInset),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalInset),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalInset),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalInset),
            
            // numberOfTaskLabel
            numberOfTaskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            numberOfTaskLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            numberOfTaskLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // titleTaskLabel
            titleTaskLabel.leadingAnchor.constraint(equalTo: numberOfTaskLabel.trailingAnchor, constant: 10),
            titleTaskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleTaskLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleTaskLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        numberOfTaskLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
}
