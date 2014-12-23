//
//  ProvisioningProfile.swift
//  Janitor
//
//  Created by Morten Bøgh on 21/11/14.
//  Copyright (c) 2014 Just A Beech. All rights reserved.
//

import Foundation

/// Struct used to represent a .mobileprovision file.
struct ProvisioningProfile {
    let filePath: String
    var filename: String {
        return self.filePath.lastPathComponent
    }

    let name: String
    let teamName: String?
    let teamID: String?
    let creationDate: NSDate
    let expirationDate: NSDate
    var isExpired: Bool {
        return self.expirationDate.compare(NSDate()) == .OrderedAscending
    }
    var status: String {
        return isExpired ? "😡" : "😄"
    }

    /// Designated initializer
    init?(filePath path: String) {
        self.filePath = path

        let dictionary = ProvisioningProfile.dictionary(contentsOfFile: self.filePath)

        if dictionary["Name"] == nil { return nil }
        if dictionary["CreationDate"] == nil { return nil }
        if dictionary["ExpirationDate"] == nil { return nil }

        self.name = dictionary["Name"] as String
        self.teamName = dictionary["TeamName"] as? String
        let teamIdentifier = dictionary["TeamIdentifier"] as? [String]
        self.teamID = bind(teamIdentifier) { teamIdentifier in teamIdentifier.first }
        self.creationDate = dictionary["CreationDate"] as NSDate
        self.expirationDate = dictionary["ExpirationDate"] as NSDate
    }

    private static func decode(fileData data: NSData) -> NSData? {
        var optionalDecoder: Unmanaged<CMSDecoderRef>? = nil
        CMSDecoderCreate(&optionalDecoder)

        if let decoderRef = optionalDecoder {
            let decoder = decoderRef.takeUnretainedValue()
            CMSDecoderUpdateMessage(decoder, data.bytes, UInt(data.length))
            CMSDecoderFinalizeMessage(decoder)
            var optionalDataRef: Unmanaged<CFDataRef>? = nil
            CMSDecoderCopyContent(decoder, &optionalDataRef)
            if let dataRef = optionalDataRef {
                return dataRef.takeUnretainedValue() as NSData
            }
        }
        return nil
    }

    private static func dictionary(contentsOfFile path: String) -> NSDictionary {
        if let fileData = NSData(contentsOfFile: path) {
            if let data = ProvisioningProfile.decode(fileData: fileData) {
                return NSPropertyListSerialization.propertyListWithData(data, options: 0, format: nil, error: nil) as? NSDictionary ?? NSDictionary()
            }
        }

        return NSDictionary()
    }
}

extension ProvisioningProfile : Printable {
    var description: String {
        let name = self.name.stringByPaddingToLength(40, withString: " ", startingAtIndex: 0)
        return "\(status)  - \(name) - \(self.expirationDate)"
    }
}
