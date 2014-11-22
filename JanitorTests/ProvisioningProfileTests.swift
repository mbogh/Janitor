//
//  ProvisioningProfileTests.swift
//  Janitor
//
//  Created by Morten Bøgh on 22/11/14.
//  Copyright (c) 2014 Just A Beech. All rights reserved.
//

import Cocoa
import XCTest

class ProvisioningProfileTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testEmptyFilePath() {
        let filePath = ""
        let profile = ProvisioningProfile(filePath: filePath)
        XCTAssert(profile == nil, "Initializer should return nil when passed an empty file path.")
    }
}
