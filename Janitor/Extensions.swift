//
//  Extensions.swift
//  Janitor
//
//  Created by Morten Bøgh on 23/12/14.
//  Copyright (c) 2014 Just A Beech. All rights reserved.
//

import Foundation

/// Thanks to http://ulrikdamm.logdown.com/posts/247219
func bind<T, U>(optional : T?, f : T -> U?) -> U? {
    switch optional {
    case .Some(let v):
        return f(v)
    case .None:
        return nil
    }
}