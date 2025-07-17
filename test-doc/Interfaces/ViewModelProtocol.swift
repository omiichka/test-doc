//
//  ViewModelProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    associatedtype Item: ItemProtocol
    associatedtype Service: ServiceProtocol
    
    var items: [Item] { get }
    var publisher: Published<[Item]>.Publisher { get }
    
    func fetch()
}
