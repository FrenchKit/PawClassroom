//
//  XKCDTests.swift
//  XKCDTests
//
//  Created by Micha Mazaheri on 9/6/17.
//  Copyright © 2017 Paw. All rights reserved.
//

import XCTest
import Mockingjay
@testable import XKCD

class XKCDTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        // Stub for XKCD API
// @TODO uncomment this
//        let body = [
//            "title": "Café Allongé",
//            "alt": "Drink coffee",
//            "img": "https://imgs.xkcd.com/comics/cafe-allonge.png",
//        ]
//        stub(http(.get, uri: "https://xkcd.com/info.0.json"), json(body))

        // Stub for image
// @TODO uncomment this
//        let imageData = try! Data(contentsOf: Bundle(identifier: "com.luckymarmot.demos.XKCD.XKCDTests")!.url(forResource: "pattern", withExtension: "png")!)
//        stub(http(.get, uri: "https://imgs.xkcd.com/comics/cafe-allonge.png"), http(200, headers: ["Content-Type" : "image/png"], download: Download.content(imageData)))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLoadXKCD() {
        let expectation = self.expectation(description: "fetch XKCD comic")

        let _ = XKCDAPI().loadLatestComic().then { (comic: XKCDComic) -> Void in
            XCTAssertFalse(comic.title.isEmpty)
            XCTAssertFalse(comic.alt.isEmpty)
            XCTAssertFalse(comic.imageUrl.isFileURL)
        }.catch { (error: Error) in
            debugPrint(error)
            XCTFail()
        }.always {
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 5.0, handler: nil)
   }
}
