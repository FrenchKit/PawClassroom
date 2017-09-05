//
//  ViewController.swift
//  XKCD
//
//  Created by Micha Mazaheri on 9/6/17.
//  Copyright © 2017 Paw. All rights reserved.
//

import Cocoa

import Alamofire
import AlamofireImage

class ViewController: NSViewController {
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var altLabel: NSTextField!
    @IBOutlet weak var imageView: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadComic()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func loadComic() -> Void {
        Alamofire.request("https://xkcd.com/info.0.json").responseJSON  { (response: DataResponse<Any>) in
            guard let d = response.result.value as? [String:Any],
                  let imageUrlStr = d["img"] as? String else {
                return
            }

            Alamofire.request(imageUrlStr).responseImage (completionHandler: { (imgResponse: DataResponse<Image>) in
                guard let image = imgResponse.result.value else {
                    return
                }
                self.refreshUI(data: d, image: image)
            })
        }
    }
    
    func refreshUI(data: [String:Any], image: NSImage) {
        guard let title = data["safe_title"] as? String,
              let alt = data["alt"] as? String else {
            return
        }
        titleLabel.stringValue = title
        altLabel.stringValue = alt
        imageView.image = image
    }
}
    
