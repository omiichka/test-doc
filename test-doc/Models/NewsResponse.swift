//
//  NewsResponse.swift
//  test-doc
//
//  Created by Artem Golovanev on 14.07.2025.
//

import Foundation

struct NewsResponse: Codable {
    let news: [NewsItem]
    let totalCount: Int
}
