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
    
    var didEnterRegionObserver: Signal<CLCircularRegion, Never> {
        serviceProvider.didEnterRegionObserver
    }
    
    var didExitRegionObserver: Signal<CLCircularRegion, Never> {
        serviceProvider.didExitRegionObserver
    }
    
    init(serviceProvider: LocationServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func startMonitoring(regions: [CLCircularRegion]) {
        serviceProvider.startMonitoringRegions(regions: regions)
    }
    
    func stopMonitoring(regions: [CLCircularRegion]) {
        serviceProvider.stopMonitoringRegions(regions: regions)
    }
    
    func prepareCircularRegions(geoRegions: [GeoRegionObject]) -> [CLCircularRegion] {
        let sorted = geoRegions.sorted { first, second -> Bool in
            var firstDistance = 0.0
            var secondDistance = 0.0
            if let coordinates = first.coordinate2D {
                firstDistance = currentLocation.value.distance(from: CLLocation(coordinates: coordinates ))
            }
            if let coordinates = second.coordinate2D {
                secondDistance = currentLocation.value.distance(from: CLLocation(coordinates: coordinates ))
            }
            return firstDistance < secondDistance
        }
        let dropCount = sorted.count > 20 ? sorted.count - 20 : 0
        let dropped = sorted.dropLast(dropCount)
        
        return dropped.compactMap { geoRegion -> CLCircularRegion? in
            if let center = geoRegion.coordinate2D, let radius = geoRegion.radius, let id = geoRegion.identifier {
                let circle = CLCircularRegion(center: center, radius: radius, identifier: id)
                circle.notifyOnEntry = true
                circle.notifyOnExit = true
                return circle
            }
            return nil
        }
    }
    
    func getCountryOfLocation(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let currentLocPlacemark = placemarks?.first else { return }
//            Current.loginSession.user?.country = currentLocPlacemark.isoCountryCode            
        }
    }
}

extension CLLocation {
    convenience init(coordinates: CLLocationCoordinate2D) {
        self.init(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}
