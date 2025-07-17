//
//  ServiceProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit

protocol ServiceProtocol {
    associatedtype Response: Decodable
    
    func fetch(urlString: String, page: Int, count: Int) async throws -> Response
    
    func loadData(from url: URL) async throws -> Data?
}
