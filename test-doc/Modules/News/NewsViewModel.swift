//
//  NewsViewModel.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation
import Combine

final class NewsViewModel<Item: ItemProtocol, Service: ServiceProtocol, Mapper: MapperProtocol>: ViewModelProtocol where Mapper.Response == Service.Response, Mapper.Item == Item {
    
    @Published
    var isLoading = false
    
    @Published
    var items: [Item] = []
    
    var publisher: Published<[Item]>.Publisher { $items }
    
    private let service: Service
    private let mapper: Mapper
    
    private var totalCount = 0
    private var currentPage = 1
    private let pageSize = 15
    private var canLoadMore = true
    
    init(service: Service, mapper: Mapper) {
        self.service = service
        self.mapper = mapper
    }
   
    
    func fetch() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            defer { isLoading = false }
            do {
                let response = try await service.fetch(urlString: "https://webapi.autodoc.ru/api/news/", page: currentPage, count: pageSize)
                let items = mapper.map(response: response)
                let totalCount = mapper.totalCount(from: response)
                await MainActor.run {
                    self.totalCount = totalCount
                    self.items += items
                    currentPage += 1
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

