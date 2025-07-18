//
//  NewsService.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit

struct NewsService<Response: Decodable>: ServiceProtocol {
    
    func fetch(urlString: String, page: Int, count: Int) async throws -> Response {
        let urlString = "\(urlString)\(page)/\(count)"
        guard let url = URL(string: urlString) else { throw ServiceError.invalidURL(urlString) }
        do {
            let data = try await execute(from: url)
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
    
    func loadData(from url: URL?) async throws -> Data? {
        guard let url else { throw ServiceError.castError(url?.absoluteString ?? "") }
        if let cached = ImageCache.shared.image(by: url) { return cached.pngData() }
        do {
            let data = try await execute(from: url)
            guard let image = UIImage(data: data) else { throw ServiceError.castError(url.absoluteString) }
            ImageCache.shared.add(image: image, for: url)
            return image.pngData()
        } catch {
            throw ServiceError.unknown(error)
        }
    }
}

private extension NewsService {
    
    func execute(from url: URL) async throws -> Data {
        let (data, urlResponse) = try await PinnedSessionProvider.shared.session.data(from: url)
        guard let httpResponse = urlResponse as? HTTPURLResponse else { throw ServiceError.castError(url.absoluteString) }
        guard (200..<300).contains(httpResponse.statusCode) else { throw ServiceError.requestError(httpResponse.statusCode) }
        return data
    }
}
