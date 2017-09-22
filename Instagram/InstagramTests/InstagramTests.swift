//
//  InstagramTests.swift
//  InstagramTests
//
//  Created by Micha Mazaheri on 9/21/17.
//  Copyright © 2017 Paw. All rights reserved.
//

import XCTest
@testable import Instagram

class InstagramTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let expectation = self.expectation(description: "fetch XKCD comic")
        
        let _ = Instagram().loadImages(tag: "mac").then { (pictures: [InstagramPicture]) -> Void in
            XCTAssertNotEqual(pictures.count, 0)
        }.catch { (error: Error) in
            XCTFail("Failing with error")
        }.always {
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)

    }
}
