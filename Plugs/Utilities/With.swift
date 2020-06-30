//
//  With.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/11/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation

@discardableResult
public func with<T>(
    _ value: T,
    _ builder: (inout T) throws -> Void
) rethrows -> T {
    var mutableValue = value
    try builder(&mutableValue)
    return mutableValue
}

@discardableResult
public func withNonNil<T: OptionalProtocol>(
    _ value: T,
    _ builder: (inout T.Wrapped) throws -> Void
) rethrows -> T {
    if var mutableValue = value.optional {
        try builder(&mutableValue)
        return T(reconstructing: mutableValue)
    } else {
        return value
    }
}
