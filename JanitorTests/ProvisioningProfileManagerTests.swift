//
//  ProvisioningProfileManagerTests.swift
//  Janitor
//
//  Created by Morten Bøgh on 01/12/14.
//  Copyright (c) 2014 Just A Beech. All rights reserved.
//

import Cocoa
import XCTest

class ProvisioningProfileManagerTests: XCTestCase {
    let profileManager = ProvisioningProfileManager()

    // Yes this is a pretty vulnerable test
    func testListOfProfilesCount() {
        var error: NSError?
        let path = "\(NSHomeDirectory())/Library/MobileDevice/Provisioning Profiles/"
        if let files = NSFileManager.defaultManager().contentsOfDirectoryAtPath(path, error: &error) as? [String] {
            let provisioningFiles = files.filter{filename in filename.hasSuffix(".mobileprovision")}

            let list = self.profileManager.list()
            XCTAssertTrue(provisioningFiles.count == list.count, "Profile manager should return the same aoumt of objects as there are .mobileprovision files in ~/Library/MobileDevice/Provisioning Profiles/.")
        }
    }

}
