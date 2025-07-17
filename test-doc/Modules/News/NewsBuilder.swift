//
//  NewsBuilder.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit

struct NewsBuilder: BuilderProtocol {
    
    static func build() -> UIViewController {
        let mapper = NewsMapper()
        let service = NewsService<NewsResponse>()
        let adapter = NewsViewAdapter<NewsItem, NewsCell<NewsItem>>()
        let view = NewsView(adapter: adapter)
        let viewModel = NewsViewModel(service: service, mapper: mapper)
        let controller = NewsViewController(contentView: view, viewModel: viewModel)
        return controller
    }
}

