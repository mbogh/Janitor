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

    func testProfileCreationDate() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let filePath = bundle.pathForResource("Total_Recall_Development", ofType: "mobileprovision")
        let profile = ProvisioningProfile(filePath: filePath!)
        let date =  NSDate(timeIntervalSinceReferenceDate: 436394679) // 2014/10/30 - 20:44:39 from http://blog.paddlefish.net/?page_id=90
        XCTAssertTrue(profile!.creationDate.isEqualToDate(date), "Creation date should match that of the profile.")
    }

    func testProfileExpirationDate() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let filePath = bundle.pathForResource("Total_Recall_Development", ofType: "mobileprovision")
        let profile = ProvisioningProfile(filePath: filePath!)
        let date =  NSDate(timeIntervalSinceReferenceDate: 467930679) // 2015/10/30 - 20:44:39 from http://blog.paddlefish.net/?page_id=90
        XCTAssertTrue(profile!.expirationDate.isEqualToDate(date), "Expiration date should match that of the profile.")
    }

    func testProfileIsExpired() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let filePath = bundle.pathForResource("Total_Recall_Development", ofType: "mobileprovision")
        let profile = ProvisioningProfile(filePath: filePath!)
        XCTAssertFalse(profile!.isExpired, "isExpired should should return true for future expiration dates.")

        let filePathExpired = bundle.pathForResource("Studenterhue", ofType: "mobileprovision")
        let profileExpired = ProvisioningProfile(filePath: filePathExpired!)
        XCTAssertTrue(profileExpired!.isExpired, "isExpired should should return false for past expiration dates.")
    }
}
