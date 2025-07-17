//
//  NewsViewAdapter.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit
import Combine

typealias NewsViewAdapterProtocol = NSObject & UICollectionViewDelegate & ViewAdapterProtocol

final class NewsViewAdapter<Item: ItemProtocol, Cell: CellProtocol>: NewsViewAdapterProtocol where Cell.Item == Item {
    
    enum Section { case main }
    
    var selectionPublisher: PassthroughSubject<Item, Never> = .init()

    private weak var collectionView: UICollectionView?

    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
        selectionPublisher.send(item)
    }
}

extension NewsViewAdapter {
    
    func connect(with collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        collectionView.delegate = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "\(Cell.self)")

        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { view, path, item in
            let cell = view.dequeueReusableCell(withReuseIdentifier: "\(Cell.self)", for: path)
            guard let castedCell = cell as? Cell else { return UICollectionViewCell() }
            castedCell.update(with: item)
            return castedCell
        }
    }

    func update(with items: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
