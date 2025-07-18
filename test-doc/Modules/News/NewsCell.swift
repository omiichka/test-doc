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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with item: Item) {
        if item.isEmpty {
            showSkeleton()
        } else {
            hideSkeleton()
            titleLabel.text = item.cellTitle
            imageView.image = getImage(from: item.imageData)
        }
    }
}

private extension NewsCell {
    
    func setupUI() {
        backgroundColor = .bg
        contentView.backgroundColor = .dark
        contentView.layer.cornerRadius = 10
        
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .text
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.8
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 250),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7)
        ])
    }
        
    func getImage(from data: Data?) -> UIImage {
        guard let data, let image = UIImage(data: data) else { return .no }
        return image
    }
    
    func showSkeleton() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0.65
        animation.duration = 0.65
        animation.autoreverses = true
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "animation")
    }
    
    func hideSkeleton() {
        layer.removeAnimation(forKey: "animation")
    }
}

