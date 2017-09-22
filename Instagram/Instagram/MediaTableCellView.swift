//
//  MediaTableCellView.swift
//  Instagram
//
//  Created by Micha Mazaheri on 9/21/17.
//  Copyright © 2017 Paw. All rights reserved.
//

import Cocoa

class MediaTableCellView: NSTableCellView {
    @IBOutlet weak var usernameLabel: NSTextField!
    @IBOutlet weak var locationLabel: NSTextField!
    @IBOutlet weak var userProfileImageView: LazyImageView!
    @IBOutlet weak var pictureImageView: LazyImageView!

    override var objectValue: Any? {
        didSet {
            if let picture = objectValue as? InstagramPicture {
                usernameLabel.stringValue = picture.username
                userProfileImageView.imageURL = picture.userProfileUrl
                locationLabel.stringValue = picture.location
                pictureImageView.imageURL = picture.imageUrl
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userProfileImageView.wantsLayer = true
        userProfileImageView.layer!.cornerRadius = userProfileImageView.bounds.size.width / 2
        userProfileImageView.layer!.masksToBounds = true
    }
}
