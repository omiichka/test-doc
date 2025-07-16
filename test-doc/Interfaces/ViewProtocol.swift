//
//  ViewProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit

protocol ViewProtocol: UIView {
    associatedtype Item: ItemProtocol
    associatedtype Cell: CellProtocol
    
    func update(with items: [Item])
}
