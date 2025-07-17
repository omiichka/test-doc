//
//  ViewProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit

protocol ViewProtocol: UIView {
    associatedtype Adapter: ViewAdapterProtocol
    
    var adapter: Adapter { get }
    
}
