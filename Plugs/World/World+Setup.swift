//
//  World+Setup.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/10/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import GoogleMaps
import GooglePlaces
import GoogleMapsDirections
import Foundation

extension World {
    
    static func setup() {
        setupGoogle()
    }

    private static func setupGoogle() {
        GMSServices.provideAPIKey(AppEnvironment.current.googleMapConfig.apiKey)
        GMSPlacesClient.provideAPIKey(AppEnvironment.current.googleMapConfig.apiKey)
        GoogleMapsDirections.provide(apiKey: AppEnvironment.current.googleMapConfig.apiKey)
    }

}
