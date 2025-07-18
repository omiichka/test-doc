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
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новости"
        bindViewModel()
        viewModel.fetch()
    }
}

private extension NewsViewController {
    
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
                self?.showWebView(with: item.webviewURL)
            }
            .store(in: &bag)
        
        contentView
            .adapter
            .bottomScrollPublisher
            .sink { [weak self] in
                self?.viewModel.fetch()
            }
            .store(in: &bag)
    }
    
    func showWebView(with url: URL?) {
        guard let url else { return } //?
        let controller = WebViewController(url: url)
        let navigation = UINavigationController(rootViewController: controller)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}

