//
//  NewsController.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit
import Combine

final class NewsViewController<View: ViewProtocol, ViewModel: ViewModelProtocol>: UIViewController, ViewControllerProtocol where View.Adapter.Item == ViewModel.Item {
    
    let contentView: View
    let viewModel: ViewModel
    
    private var bag: Set<AnyCancellable> = .init()
    
    init(contentView: View, viewModel: ViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetch()
//        viewModel.fetchMockData()
    }


}

private extension NewsViewController {
    
    func setupUI() {
        title = "Новости"
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func bindViewModel() {
        viewModel
            .publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.contentView.adapter.update(with: items)
            }
            .store(in: &bag)
        
        contentView
            .adapter
            .selectionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
               
            }
            .store(in: &bag)
    }
}

