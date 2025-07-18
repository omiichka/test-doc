//
//  ViewModelProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    associatedtype Item: ItemProtocol
    
    var items: [Item] { get }
    var isLoading: Bool { get }
    
    var itemPublisher: Published<[Item]>.Publisher { get }
    var loadPublisher: Published<Bool>.Publisher { get }
    
    func fetch()
}
