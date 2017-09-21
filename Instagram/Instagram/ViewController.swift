//
//  ViewController.swift
//  Instagram
//
//  Created by Micha Mazaheri on 9/21/17.
//  Copyright © 2017 Paw. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let _ = Instagram().loadImages(tag: "vegan").then { (pictures: [InstagramPicture]) -> Void in
            debugPrint(pictures)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
