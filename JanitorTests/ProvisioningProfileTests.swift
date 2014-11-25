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

    func testFilenameAndFilePath() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let filePath = bundle.pathForResource("Total_Recall_Development", ofType: "mobileprovision")
        let profile = ProvisioningProfile(filePath: filePath!)
        XCTAssert(profile?.filePath == filePath, "Filepath should match the filepath used to initialize the object.")
        XCTAssert(profile?.filename == filePath?.lastPathComponent, "Filename should match the last path component of the filePath")
    }

    func testProfileName() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let filePath = bundle.pathForResource("Total_Recall_Development", ofType: "mobileprovision")
        let profile = ProvisioningProfile(filePath: filePath!)
        XCTAssert(profile?.name == "Total Recall Development", "Name should match that of the profile :)")
    }

    func testProfileTeamName() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let filePath = bundle.pathForResource("Total_Recall_Development", ofType: "mobileprovision")
        let profile = ProvisioningProfile(filePath: filePath!)
        XCTAssert(profile?.teamName == "Morten Soerensen", "Team name should match that of the profile.")
    }

    func testProfileTeamID() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let filePath = bundle.pathForResource("Total_Recall_Development", ofType: "mobileprovision")
        let profile = ProvisioningProfile(filePath: filePath!)
        XCTAssert(profile?.teamID == "6Y3N739X56", "Team ID should match that of the profile.")
    }
}
