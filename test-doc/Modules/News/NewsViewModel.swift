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
    private let urlString = "https://webapi.autodoc.ru/api/news/"
    
    private var totalCount = 0
    private var currentPage = 1
    private let pageSize = 15
    private var canLoadMore = true
    
    init(service: Service, mapper: Mapper) {
        self.service = service
        self.mapper = mapper
    }
   
    
    func fetch() {
        isLoading = true
        Task {
            defer { isLoading = false }
            do {
                let response = try await service.fetch(urlString: urlString, page: currentPage, count: pageSize)
                let items = mapper.map(response: response)
                let totalCount = mapper.totalCount(from: response)
                let mappedItems = await mapper.mapWithImages(items: items) { [weak self] in
                    try await self?.service.loadData(from: $0)
                }.sorted(by: { $0.id > $1.id })
                await MainActor.run {
                    self.totalCount = totalCount
                    self.items += mappedItems
                    currentPage += 1
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

