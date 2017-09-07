//
//  XKCD.swift
//  XKCD
//
//  Created by Micha Mazaheri on 9/7/17.
//  Copyright © 2017 Paw. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import AlamofireImage

struct XKCDComic {
    var title: String
    var alt: String
    var imageUrl: URL
    var image: NSImage
}

enum XKCDError: Error {
    case invalidResponse
    case invalidImageResponse
}

class XKCD {
    func loadDefaultComic() -> Promise<XKCDComic> {
        return Promise(resolvers: { (success, fail) in
            Alamofire.request("https://xkcd.com/info.0.json").responseJSON  { (response: DataResponse<Any>) in
                guard let d = response.result.value as? [String:Any],
                      let title = d["title"] as? String,
                      let alt = d["alt"] as? String,
                      let imageUrlStr = d["img"] as? String else {
                    fail(XKCDError.invalidResponse)
                    return
                }
                Alamofire.request(imageUrlStr).responseImage (completionHandler: { (imgResponse: DataResponse<Image>) in
                    guard let image = imgResponse.result.value else {
                        fail(XKCDError.invalidImageResponse)
                        return
                    }
                    let comic = XKCDComic(title: title, alt: alt, imageUrl: URL(string: imageUrlStr)!, image: image)
                    success(comic)
                })
            }
        })
    }
}
