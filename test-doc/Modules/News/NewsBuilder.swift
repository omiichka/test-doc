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
        let view = NewsView<NewsItem, NewsCell<NewsItem>>()
        let viewModel = NewsViewModel(service: service, mapper: mapper)
        let controller = NewsViewController(contentView: view, viewModel: viewModel)
        return controller
    }
}

