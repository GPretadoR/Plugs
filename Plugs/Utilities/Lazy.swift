//
//  Lazy.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/11/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation

@propertyWrapper
final class Lazy<T> {
    private var value: T?
    private var builder: () -> T
    
    var wrappedValue: T {
        return value ?? builder()
    }
    
    var projectedValue: Lazy {
        return self
    }
    
    init(wrappedValue: @escaping @autoclosure () -> T) {
        self.builder = wrappedValue
    }
    
    // MARK: - Public
    
    func reset() {
        self.value = nil
    }
    
    var valueIfLoaded: T? {
        return self.value
    }
}
