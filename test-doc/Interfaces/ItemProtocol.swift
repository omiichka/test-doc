//
//  ItemProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

typealias ItemType = Codable & Hashable & Identifiable

protocol ItemProtocol: ItemType where ID == Int {
    var cellTitle: String { get }
    var imageData: Data? { get set }
    var webviewURL: URL? { get }
    var isEmpty: Bool { get }
    
    static func mock() -> [Self]
}
