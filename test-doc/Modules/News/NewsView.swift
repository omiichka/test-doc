//
//  NewsView.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit
import Combine

final class NewsView<Adapter: ViewAdapterProtocol>: UIView, ViewProtocol {
    
    var adapter: Adapter
  
    private lazy var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: layout)

    init(adapter: Adapter) {
        self.adapter = adapter
        super.init(frame: .zero)
        setupUI()
        adapter.connect(with: collectionView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewsView {
    
    func setupUI() {
        collectionView.backgroundColor = .bg
        addSubview(collectionView)
        mapConstraint(for: collectionView)
    }

    var layout: UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.7))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.interItemSpacing = .fixed(15)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        return UICollectionViewCompositionalLayout(section: section)
    }
}
