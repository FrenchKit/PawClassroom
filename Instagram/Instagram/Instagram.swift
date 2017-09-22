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
import SwiftyJSON

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
        // @TODO Insert here your Instagram Access Token
        return "6082558564.fd763d7.f1cfaeff77d348a59a28a08667bea2ab"
    }

    private func parseInstagramPicture(data: JSON) -> InstagramPicture? {
        guard let username = data["user"]["username"].string,
              let userProfileUrl = data["user"]["profile_picture"].url,
              let imageUrl = data["images"]["standard_resolution"]["url"].url else {
            return nil
        }
        let location = data["location"]["name"].string ?? ""
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
                guard let pictureArray = JSON(data: response.data!)["data"].array else {
                    fail(InstagramError.invalidResponse)
                    return
                }
                let pictures = pictureArray.flatMap({ (data: JSON) -> InstagramPicture? in
                    return self.parseInstagramPicture(data: data)
                })
                success(pictures)
            }
        })
    }
}
