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
  
    private lazy var collectionView: UICollectionView = {
       let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .bg
        addSubview(collection)
        return collection
    }()

    init(adapter: Adapter) {
        self.adapter = adapter
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewsView {
    
    func setup() {
        mapConstraint(for: collectionView)
        adapter.connect(with: collectionView)
    }

    var layout: UICollectionViewLayout {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(250))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 35
        return UICollectionViewCompositionalLayout(section: section)
    }
}
