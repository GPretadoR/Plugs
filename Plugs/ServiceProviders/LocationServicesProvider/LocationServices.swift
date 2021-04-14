//
//  LocationServices.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 6/3/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import ReactiveSwift
import CoreLocation

protocol LocationServices {
    var currentLocation: MutableProperty<CLLocation> {get set}
}
