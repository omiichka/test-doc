//
//  ServiceProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

protocol ServiceProtocol {
    associatedtype Response: Decodable
    
    func fetch(urlString: String, page: Int, count: Int) async throws -> Response
}
