//
//  ImageCache.swift
//  test-doc
//
//  Created by Artem Golovanev on 17.07.2025.
//

import UIKit

final class ImageCache {

    static let shared = ImageCache()

    private let cache = NSCache<NSURL, UIImage>()

    private init() {}

    func image(by url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }

    func add(image: UIImage?, for url: URL) {
        guard let image = image else { return }
        cache.setObject(image, forKey: url as NSURL)
    }
}
