//
//  ProvisioningProfileManager.swift
//  Janitor
//
//  Created by Morten Bøgh on 01/12/14.
//  Copyright (c) 2014 Just A Beech. All rights reserved.
//

import Foundation

class ProvisioningProfileManager {
    func list() -> [ProvisioningProfile] {
        var profiles: [ProvisioningProfile] = []

        var error: NSError?
        let path = "\(NSHomeDirectory())/Library/MobileDevice/Provisioning Profiles/"
        if let files = NSFileManager.defaultManager().contentsOfDirectoryAtPath(path, error: &error) as? [String] {
            let provisioningFiles = files.filter{filename in filename.hasSuffix(".mobileprovision")}
            for provisioningFile in provisioningFiles {
                if let profile = ProvisioningProfile(filePath: path.stringByAppendingPathComponent(provisioningFile)) {
                    profiles.append(profile)
                }
            }
        }
        return profiles
    }
}