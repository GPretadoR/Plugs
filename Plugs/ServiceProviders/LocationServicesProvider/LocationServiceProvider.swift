//
//  LocationServiceProvider.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 6/3/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import ReactiveSwift
import CoreLocation

class LocationServiceProvider: NSObject, LocationServices {
    
    var currentLocation = MutableProperty<CLLocation>(CLLocation())
    var (locationObserver, locationSignal) = Signal<CLLocation, Never>.pipe()
    var (locationAuthorizationObserver, locationAuthorizationSignal) = Signal<CLAuthorizationStatus, Never>.pipe()
    
    var pausesLocationUpdatesAutomatically: Bool {
        set { locationManager.pausesLocationUpdatesAutomatically = newValue }
        get { return locationManager.pausesLocationUpdatesAutomatically }
    }
    
    var allowsBackgroundLocationUpdates: Bool {
        set { locationManager.allowsBackgroundLocationUpdates = newValue }
        get { return locationManager.allowsBackgroundLocationUpdates }
    }
    
    var isDeferredLocationUpdateAvailable: Bool {
        return CLLocationManager.deferredLocationUpdatesAvailable()
    }
    
    private let kLocationDistanceFilter: CLLocationDistance = 10
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        configure()
    }
    
    // MARK: - Public functions
    func updateLocation() {
        locationManager.requestLocation()
    }
    
    private func enableUpdateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func disableUpdateLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    private func enableUpdateHeading() {
        locationManager.startUpdatingHeading()
    }
    
    private func disableUpdateHeading() {
        locationManager.stopUpdatingHeading()
    }
    
    // MARK: - Private functions
    
    private func configure() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.activityType = .fitness
//        locationManager.distanceFilter = kLocationDistanceFilter
        locationManager.delegate = self
        requestAuthorizationForLocationService()
    }
    
    private func requestAuthorizationForLocationService() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted, .denied:
            disableUpdateLocation()
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            break
        @unknown default:
            fatalError()
        }
    }
    
}

extension LocationServiceProvider: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation.value = location
            locationSignal.send(value: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            disableUpdateLocation()
        case .notDetermined:
            requestAuthorizationForLocationService()
        case .authorizedAlways, .authorizedWhenInUse:
            enableUpdateLocation()
        default:
            break
        }
        locationAuthorizationSignal.send(value: status)
        locationAuthorizationSignal.sendCompleted()
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        disableUpdateLocation()
        locationSignal.sendInterrupted()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {}
}
