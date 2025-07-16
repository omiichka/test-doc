//
//  NewsItem.swift
//  test-doc
//
//  Created by Artem Golovanev on 14.07.2025.
//

import Foundation

struct NewsItem {
    let id: Int
    let title: String
    let description: String
    let publishedDate: String
    let url: String
    let fullUrl: URL
    let titleImageUrl: URL
    let categoryType: String
}

extension NewsItem: ItemProtocol {
    
    var viewTitle: String {
        title
    }
    
    var viewURL: String {
        url
    }
}
