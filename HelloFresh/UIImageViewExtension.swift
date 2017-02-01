//
//  UIImageViewExtension.swift
//  HelloFresh
//
//  Created by Pietro Santececca on 30/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { [unowned self] (data, response, error) in
            guard   let httpURLResponse = response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType,
                    mimeType.hasPrefix("image"),
                    let data = data,
                    error == nil,
                    let image = UIImage(data: data)
                    else { return }
            DispatchQueue.main.async() { self.image = image }
        }.resume()
    }
    
    func downloadedFrom(link: String?, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let link = link, let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
