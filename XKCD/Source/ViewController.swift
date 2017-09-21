//
//  ViewController.swift
//  XKCD
//
//  Created by Micha Mazaheri on 9/6/17.
//  Copyright © 2017 Paw. All rights reserved.
//

import Cocoa

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
        // Load latest XKCD comic
        let _ = XKCDAPI().loadLatestComic().then { (comic: XKCDComic) -> Void in
            self.refreshUI(comic: comic)
        }
    }
    
    func refreshUI(comic: XKCDComic) {
        titleLabel.stringValue = comic.title
        altLabel.stringValue = comic.alt
        imageView.image = comic.image
    }
}
    
