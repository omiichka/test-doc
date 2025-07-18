//
//  MapperProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

typealias MapperCallback = (URL?) async throws -> Data?

protocol MapperProtocol {
    associatedtype Response: Decodable
    associatedtype Item: ItemProtocol

    func map(response: Response) -> [Item]
    func totalCount(from response: Response) -> Int
    func mapWithImages(items: [Item], callback: @escaping MapperCallback) async -> [Item]
}
