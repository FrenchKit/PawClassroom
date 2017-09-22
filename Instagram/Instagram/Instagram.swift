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
    var userProfileUrl: URL
    var location: String
    var imageUrl: URL
}

enum InstagramError: Error {
    case invalidResponse
    case invalidImageResponse
}

class Instagram {
    private func getAccessToken() -> String {
        return "6082558564.fd763d7.f1cfaeff77d348a59a28a08667bea2ab"
    }

    private func parseInstagramPicture(data: Any?) -> InstagramPicture? {
        guard let d = data as? [String:Any],
              let username = (d["user"] as? [String:Any])?["username"] as? String,
              let userProfileUrlStr = (d["user"] as? [String:Any])?["profile_picture"] as? String,
              let userProfileUrl = URL(string: userProfileUrlStr),
              let imageUrlStr = ((d["images"] as? [String:Any])?["standard_resolution"] as? [String:Any])?["url"] as? String,
              let imageUrl = URL(string: imageUrlStr) else {
            return nil
        }
        let location = (d["location"] as? [String:Any])?["name"] as? String ?? ""
        return InstagramPicture(username: username, userProfileUrl: userProfileUrl, location: location, imageUrl: imageUrl)
    }


    /// Loads images from Instagram for a given tag
    ///
    /// - Parameters:
    ///   - tag: Instagram tag to load
    ///   - count: Number of images to load
    /// - Returns: A promise resolving to an array of InstagramPicture
    func loadImages(tag: String, count: Int = 30) -> Promise<[InstagramPicture]> {
        return Promise(resolvers: { (success, fail) in
            let urlString = "https://api.instagram.com/v1/tags/\(tag)/media/recent?count=\(count)&access_token=\(getAccessToken())"
            Alamofire.request(urlString).responseJSON  { (response: DataResponse<Any>) in
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
