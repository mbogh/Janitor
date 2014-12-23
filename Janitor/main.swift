//
//  main.swift
//  Janitor
//
//  Created by Morten Bøgh on 20/11/14.
//  Copyright (c) 2014 Just A Beech. All rights reserved.
//

import Foundation

enum Commands: String {
    case Help = "help"
    case List = "list"
    case Version = "version"

    init(_ rawValueSafe: String?) {
        if let rawValue = rawValueSafe {
            self = Commands(rawValue: rawValue) ?? .Help
        }
        else {
            self = Commands.Help
        }
    }
}

// Fetch arguments passed to the executable.
var arguments = Process.arguments

// Remove the executable name.
arguments.removeAtIndex(0)

// Create verb from argument
let verb = Commands(arguments.first)

// Remove verb from arguments
if arguments.count > 0 {
    arguments.removeAtIndex(0)
}

switch verb {
case .Help:
    println("Help")
case .List:
    println("List of profiles")
    let profileManager = ProvisioningProfileManager()
    let profiles = profileManager.list().reduce(""){previous, next in "\(previous)\n\(next)"}
    println("\(profiles)")
case .Version:
    let versionString = "0.0.1"
    println("\(versionString)")
}