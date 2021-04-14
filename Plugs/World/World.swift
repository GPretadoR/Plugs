//
//  World.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/10/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation

//#if DEBUG
//var Current = World(context: Context())
//#else
//let Current = World(context: Context())
//#endif

var Current = World(context: Context())

struct World {
    
    var context: Context
    
    let environment = AppEnvironment.current
    
    init(context: Context) {
        self.context = context
    }
}
