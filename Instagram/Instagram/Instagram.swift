//
//  Instagram.swift
//  Instagram
//
//  Created by Micha Mazaheri on 9/21/17.
//  Copyright © 2017 Paw. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import AlamofireImage

struct InstagramPicture {
    var username: String
    var imageUrl: URL
}

enum InstagramError: Error {
    case invalidResponse
    case invalidImageResponse
}

class Instagram {
    private func getAccessToken() -> String {
        return "3692442.97fe75d.de7b62d734254d1ba81d84a0e5fee723"
    }

    private func parseInstagramPicture(data: Any?) -> InstagramPicture? {
        guard let d = data as? [String:Any],
              let username = (d["user"] as? [String:Any])?["username"] as? String,
              let imageUrlStr = ((d["images"] as? [String:Any])?["standard_resolution"] as? [String:Any])?["url"] as? String,
              let imageUrl = URL(string: imageUrlStr) else {
            return nil
        }
        return InstagramPicture(username: username, imageUrl: imageUrl)
    }

    func loadImages(tag: String, count: Int = 30) -> Promise<[InstagramPicture]> {
        return Promise(resolvers: { (success, fail) in
            Alamofire.request("https://api.instagram.com/v1/tags/\(tag)/media/recent?count=\(count)&access_token=\(getAccessToken())").responseJSON  { (response: DataResponse<Any>) in
                guard let pictureList = (response.result.value as? [String:Any])?["data"] as? [[String:Any]] else {
                    fail(InstagramError.invalidResponse)
                    return
                }
                let pictures = pictureList.flatMap({ (data: [String : Any]) -> InstagramPicture? in
                    return self.parseInstagramPicture(data: data)
                })
                success(pictures)
            }
        })
    }
}
