//
//  NewsMapper.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

struct NewsMapper: MapperProtocol {
    func map(response: NewsResponse) -> [NewsItem] {
        response.news
    }

    func totalCount(from response: NewsResponse) -> Int {
        response.totalCount
    }
    
    func mapWithImages(items: [NewsItem], callback: @escaping MapperCallback) async -> [NewsItem] {
        await withTaskGroup(of: NewsItem.self) { group in
            for item in items {
                group.addTask {
                    let image = try? await callback(item.titleImageUrl)
                    return item.copy(with: image)
                }
            }
            var result: [NewsItem] = []
            for await item in group {
                result.append(item)
            }
            return result
        }
    }
}
