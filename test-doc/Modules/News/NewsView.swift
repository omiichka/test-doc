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
       let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.backgroundColor = .bg
        addSubview(collection)
        return collection
    }()
    
    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activity)
        return activity
    }()

    init(adapter: Adapter) {
        self.adapter = adapter
        super.init(frame: .zero)
        layout()
        adapter.connect(with: collectionView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoader() {
        activity.startAnimating()
    }
    
    func stopLoader() {
        activity.stopAnimating()
    }
}

private extension NewsView {
    
    func layout() {
        mapConstraint(for: collectionView)
        
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: centerXAnchor),
            activity.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    var collectionLayout: UICollectionViewLayout {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(250))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 35
        section.contentInsets = .init(top: 0, leading: 0, bottom: 40, trailing: 0)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
