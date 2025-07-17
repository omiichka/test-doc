//
//  ViewAdapterProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit
import Combine

protocol ViewAdapterProtocol: AnyObject {
    associatedtype Item: ItemProtocol
    
    var selectionPublisher: PassthroughSubject<Item, Never> { get }
    
    func connect(with collectionView: UICollectionView)
    func update(with items: [Item])
}
