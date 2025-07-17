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
    
    var imageData: Data? = nil
}

extension NewsItem {
    
    func copy(with data: Data?) -> NewsItem {
        var copy = self
        copy.imageData = data
        return copy
    }
}

extension NewsItem: ItemProtocol {
    
    var cellTitle: String { title }
    var webviewURL: URL { fullUrl }
}
