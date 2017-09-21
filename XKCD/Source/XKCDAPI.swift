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


/// Represents a comic on XKCD
struct XKCDComic {
    var title: String
    var alt: String
    var imageUrl: URL
    var image: NSImage
}


/// Represents an XKCD API Error
enum XKCDAPIError: Error {
    case invalidResponse
    case invalidImageResponse
}


/// Represents access to the XKCD API
class XKCDAPI {

    /// Loads the latest XKCD comic.
    ///
    /// - Returns: A promise that resolves to a XKCD comic item.
    func loadLatestComic() -> Promise<XKCDComic> {
        return Promise(resolvers: { (success, fail) in
            Alamofire.request("https://xkcd.com/info.0.json").responseJSON  { (response: DataResponse<Any>) in
                guard let d = response.result.value as? [String:Any],
                      let title = d["title"] as? String,
                      let alt = d["alt"] as? String,
                      let imageUrlStr = d["img"] as? String else {
                    fail(XKCDAPIError.invalidResponse)
                    return
                }
                Alamofire.request(imageUrlStr).responseImage (completionHandler: { (imgResponse: DataResponse<Image>) in
                    guard let image = imgResponse.result.value else {
                        fail(XKCDAPIError.invalidImageResponse)
                        return
                    }
                    let comic = XKCDComic(
                        title: title,
                        alt: alt,
                        imageUrl: URL(string: imageUrlStr)!,
                        image: image
                    )
                    success(comic)
                })
            }
        })
    }
}
