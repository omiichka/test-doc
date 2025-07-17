//
//  MapperProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

protocol MapperProtocol {
    associatedtype Response: Decodable
    associatedtype Item: ItemProtocol

    func map(response: Response) -> [Item]
    func totalCount(from response: Response) -> Int
}
