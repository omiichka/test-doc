//
//  NewsService.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

struct NewsService<Response: Decodable>: ServiceProtocol {
    
    func fetch(urlString: String, page: Int, count: Int) async throws -> Response {
        let urlString = "\(urlString)\(page)/\(count)"
        guard let url = URL(string: urlString) else { throw ServiceError.invalidURL(urlString) }
        do {
            let (data, urlResponse) = try await URLSession.shared.data(from: url)
            guard let httpResponse = urlResponse as? HTTPURLResponse else { throw ServiceError.castError(urlString) }
            guard (200..<300).contains(httpResponse.statusCode) else { throw ServiceError.requestError(httpResponse.statusCode) }
            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                return result
            } catch {
                throw ServiceError.decodeError(error)
            }
        } catch {
            throw ServiceError.unknown(error)
        }
    }
}

