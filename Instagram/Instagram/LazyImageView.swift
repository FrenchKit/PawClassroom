//
//  LazyImageView.swift
//  Instagram
//
//  Created by Micha Mazaheri on 9/22/17.
//  Copyright © 2017 Paw. All rights reserved.
//

import Foundation
import AppKit
import Alamofire
import AlamofireImage

class LazyImageView: NSImageView {
    var imageURL: URL? {
        didSet {
            if let url = self.imageURL {
                downloadImage(url: url)
            }
        }
    }

    private func downloadImage(url: URL) {
        Alamofire.request(url).responseImage (completionHandler: { (imgResponse: DataResponse<Image>) in
            guard let image = imgResponse.result.value else {
                return
            }
            self.image = image
        })
    }
}
