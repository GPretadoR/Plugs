//
//  LocationService.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 6/3/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import ReactiveSwift
import CoreLocation

class LocationService {
    
    private let serviceProvider: LocationServiceProvider
    
    var currentLocation: MutableProperty<CLLocation> {
        serviceProvider.currentLocation
    }
    
    var locationObserver: Signal<CLLocation, Never> {
        serviceProvider.locationObserver
    }
    
    var locationAuthorizationObserver: Signal<CLAuthorizationStatus, Never> {
        serviceProvider.locationAuthorizationObserver
    }
    
    init(serviceProvider: LocationServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func getCountryOfLocation(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let currentLocPlacemark = placemarks?.first else { return }
//            Current.loginSession.user?.country = currentLocPlacemark.isoCountryCode            
        }
    }
    
}
