//
//  MainViewViewModel.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/27/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import FirebaseFirestore.FIRGeoPoint
import Foundation
import GoogleMapsDirections

import CoreLocation
import ReactiveSwift

protocol MainViewCoordinatorDelegate: class {
    func didTapSideMenuButton()
    func openDetailsPage(charger: ChargerStationObject)
}

class MainViewViewModel: BaseViewModel {
    
    weak var coordinatorDelegate: MainViewCoordinatorDelegate?
    private let context: Context
    
    var mapAnnotations = MutableProperty<[String]>([])
    
    var drawDirection = Signal<String, Error>.pipe()
    var moveCameraToLocation = MutableProperty<(position: CLLocationCoordinate2D, zoomLevel: Float)>((position: CLLocationCoordinate2D(), zoomLevel: 7.0))
    
    var markers = MutableProperty<[ChargerMarker]>([])
    var chargers: [ChargerStationObject] = []
    var allGeoRegionObjects: [GeoRegionObject] = []
    
    private var initialCameraMove = true
    private let initialZoomLevel: Float = 17.0
    private var regionEntryTime = Date()
    
    init(context: Context, coordinatorDelegate: MainViewCoordinatorDelegate) {
        self.context = context
        self.coordinatorDelegate = coordinatorDelegate
        super.init()
        setupReactiveComponents()
    }
    
    func showLeftMenuButtonTapped() {
        coordinatorDelegate?.didTapSideMenuButton()
    }
    
    func didTapInfoWindow(of marker: ChargerMarker) {
        #warning("Needs to be changed. Maybe name change to id or id change to name. Filter is not very good here")
        guard let charger = chargers.first(where: { $0.name == marker.id }) else { return }
        coordinatorDelegate?.openDetailsPage(charger: charger)
    }
    
    // MARK: - Private funcs
    
    private func setupReactiveComponents() {
        context.services.locationService
            .locationObserver
            .observeValues { [weak self] location in
                self?.changeCameraLocation(location: location.coordinate)
                self?.calculateRegions(geoRegions: self?.allGeoRegionObjects ?? [])
        }
        
        context.services.locationService
            .didEnterRegionObserver
            .observeValues { [weak self] region in
                self?.regionEntryTime = Date()
            }
        
        context.services.locationService
            .didExitRegionObserver
            .observeValues { [weak self] region in
                self?.handleRegionExit()
            }
        
        fetchChargers()
    }
    
    private func fetchChargers() {
        context.services.chargerStationsManagementService
            .chargerStations
            .signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] chargerStations in
                self?.handleChargersResponse(chargerStations: chargerStations)
        }
    }
    
    private func createMarkers(chargerStations: [ChargerStationObject]) -> [ChargerMarker] {
        return chargerStations.map { chargerStation -> ChargerMarker in
            let marker = ChargerMarker()
            marker.position = chargerStation.coordinate2D ?? .init()
            marker.title = chargerStation.name
            marker.snippet = chargerStation.city
            marker.id = chargerStation.name ?? ""
            marker.icon = #imageLiteral(resourceName: "chargingStationIcon")
            return marker
        }
    }
    
    private func calculateRegions(geoRegions: [GeoRegionObject]) {
        let circularRegions = context.services.locationService.prepareCircularRegions(geoRegions: geoRegions)
        context.services.locationService.startMonitoring(regions: circularRegions)
    }
    
    private func changeCameraLocation(location: CLLocationCoordinate2D) {
        if initialCameraMove {
            initialCameraMove = false
            moveCameraToLocation.value = (location, initialZoomLevel)
        }
    }
    
    private func handleRegionExit() {
        let timeDiff = Date().timeIntervalSince(regionEntryTime)
        if timeDiff > 15 * 60 {
            // Do request to firebases
        }
    }
    
    private func handleChargersResponse(chargerStations: [ChargerStationObject]) {
        chargers = chargerStations
        markers.value = createMarkers(chargerStations: chargerStations)
        var geoRegions = chargerStations.compactMap { $0.geoRegion }
        let testRegion = GeoRegionObject(identifier: "Garnik", coordinates: GeoPoint(latitude: 40.192165, longitude: 44.531235), radius: 200.0)
        geoRegions.append(testRegion)
        allGeoRegionObjects = geoRegions
        calculateRegions(geoRegions: geoRegions)
    }
}

extension CLLocationCoordinate2D {
    var googleLocationCoordinate2D: GoogleMapsDirections.LocationCoordinate2D {
        GoogleMapsDirections.LocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
