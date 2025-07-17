//
//  WebViewController.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    private let webView = WKWebView()
    private let url: URL
    
    private let activity = UIActivityIndicatorView(style: .large)


    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
        webView.load(URLRequest(url: url))
        

    }
    
    private func setupUI() {
        title = "Просмотр"
        
        webView.navigationDelegate = self
        activity.hidesWhenStopped = true
        activity.color = .gray
        
        view.addSubview(webView)
        view.addSubview(activity)
        
        view.mapConstraint(for: webView)
        view.mapConstraint(for: activity)
    }
    
    private func setupAction() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissModal)
        )
        
    }
    
    @objc
    private func dismissModal() {
        dismiss(animated: true)
    }
}

extension WebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
        debugPrint(error.localizedDescription)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
        debugPrint(error.localizedDescription)
    }
}
