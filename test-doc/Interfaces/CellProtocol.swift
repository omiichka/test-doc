//
//  CellProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit

protocol CellProtocol: UICollectionViewCell {
    associatedtype Item: ItemProtocol
    
    func update(with item: Item)
}
