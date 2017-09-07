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

        let body = [
            "title": "Café Allongé",
            "alt": "Drink coffee",
            "img": "https://imgs.xkcd.com/comics/latitude.png",
        ]
        stub(http(.get, uri: "https://xkcd.com/info.0.json"), json(body))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadXKCD() {
        let expectation = self.expectation(description: "fetch XKCD comic")

        let _ = XKCD().loadDefaultComic().then { (comic: XKCDComic) -> Void in
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
