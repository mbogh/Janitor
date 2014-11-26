//
//  main.swift
//  Janitor
//
//  Created by Morten Bøgh on 20/11/14.
//  Copyright (c) 2014 Just A Beech. All rights reserved.
//

import Foundation

var arguments = Process.arguments

// Remove the executable name.
assert(arguments.count >= 1)
arguments.removeAtIndex(0)

let verb = arguments.first ?? "help"
if arguments.count > 0 {
    // Remove the command name.
    arguments.removeAtIndex(0)
}

println("\(arguments) \(verb)")