//
//  ItemProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

typealias ItemType = Codable & Hashable

protocol ItemProtocol: ItemType {
    var viewTitle: String { get }
    var viewURL: String { get }
}
