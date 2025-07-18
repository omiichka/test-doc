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
    
    var itemPublisher: Published<[Item]>.Publisher { $items }
    var loadPublisher: Published<Bool>.Publisher { $isLoading }
    
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
        
        items = Item.mock()
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
                    removeMock()
                    currentPage += 1
                    self.totalCount = totalCount
                    self.items += mappedItems
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

private extension NewsViewModel {
    
    func removeMock() {
        guard currentPage == 1 else { return }
        items = []
    }
}
