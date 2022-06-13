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
        static let horizontalInset: CGFloat = 5
        static let verticalInset: CGFloat = 10
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
        
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            // contentView
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.horizontalInset),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.horizontalInset),
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.verticalInset),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.verticalInset),
            
            // numberOfTaskLabel
            numberOfTaskLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            numberOfTaskLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
