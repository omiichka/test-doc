//
//  NewsCell.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit

final class NewsCell<Item: ItemProtocol>: UICollectionViewCell, CellProtocol {
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with item: Item) {
        titleLabel.text = item.cellTitle
        imageView.image = getImage(from: item.imageData)
    }
}

private extension NewsCell {
    
    func setupUI() {
        contentView.backgroundColor = .dark
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .text
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .bg
        layer.cornerRadius = 4
        layer.masksToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])

    }
        
    func getImage(from data: Data?) -> UIImage {
        guard let data, let image = UIImage(data: data) else { return UIImage(systemName: "photo") ?? .remove }
        return image
    }
}

