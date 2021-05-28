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
    var (didEnterRegionObserver, didEnterRegionSignal) = Signal<CLCircularRegion, Never>.pipe()
    var (didExitRegionObserver, didExitRegionSignal) = Signal<CLCircularRegion, Never>.pipe()
    var (locationAuthorizationObserver, locationAuthorizationSignal) = Signal<CLAuthorizationStatus, Never>.pipe()
    
    var pausesLocationUpdatesAutomatically: Bool {
        set { locationManager.pausesLocationUpdatesAutomatically = newValue }
        get { return locationManager.pausesLocationUpdatesAutomatically }
    }
    
    var allowsBackgroundLocationUpdates: Bool {
        set { locationManager.allowsBackgroundLocationUpdates = newValue }
        get { return locationManager.allowsBackgroundLocationUpdates }
    }

    private let kLocationDistanceFilter: CLLocationDistance = 10
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        configure()
    }
    
    var monitoredRegions: Set<CLRegion> {
        locationManager.monitoredRegions
    }
    
    // MARK: - Public functions
    func updateLocation() {
        locationManager.requestLocation()        
    }
    
    func startMonitoringRegions(regions: [CLCircularRegion]) {        
        regions.forEach { locationManager.startMonitoring(for: $0) }
    }
    
    func stopMonitoringRegions(regions: [CLCircularRegion]) {
        regions.forEach { locationManager.stopMonitoring(for: $0) }
    }
    
    func clearMonitoredRegions() {
        locationManager.monitoredRegions.forEach { locationManager.stopMonitoring(for: $0) }
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
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
        pausesLocationUpdatesAutomatically = true
        allowsBackgroundLocationUpdates = true
        requestAuthorizationForLocationService()
    }
    
    private func requestAuthorizationForLocationService() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted, .denied:
            disableUpdateLocation()
        case .authorizedWhenInUse, .authorizedAlways:
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
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let circularRegion = region as? CLCircularRegion {
            didEnterRegionSignal.send(value: circularRegion)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let circularRegion = region as? CLCircularRegion {
            didExitRegionSignal.send(value: circularRegion)
        }
    }
}
