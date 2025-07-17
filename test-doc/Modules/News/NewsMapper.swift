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
}

