//
//  ViewControllerProtocol.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import Foundation

protocol ViewControllerProtocol: AnyObject {
    associatedtype View: ViewProtocol
    associatedtype ViewModel: ViewModelProtocol
    
    var contentView: View { get }
    var viewModel: ViewModel { get }
}
