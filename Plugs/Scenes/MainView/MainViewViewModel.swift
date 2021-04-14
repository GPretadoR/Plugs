//
//  MainViewViewModel.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/27/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import GoogleMapsDirections

import CoreLocation
import ReactiveSwift

protocol MainViewCoordinatorDelegate: class {
    func didTapSideMenuButton()
}

class MainViewViewModel: BaseViewModel {
    
    weak var coordinatorDelegate: MainViewCoordinatorDelegate?
    private let context: Context
    
    var chargerStations = MutableProperty<[ChargerStationObject]>([])
    var mapAnnotations = MutableProperty<[String]>([])
    var drawDirection = Signal<String, Error>.pipe()
    var moveCameraToLocation = Signal<(position: CLLocationCoordinate2D, zoomLevel: Float), Never>.pipe()
    
    private var initialCameraMove = true
    private let initialZoomLevel: Float = 17.0
    
    init(context: Context, coordinatorDelegate: MainViewCoordinatorDelegate) {
        self.context = context
        self.coordinatorDelegate = coordinatorDelegate
        super.init()
        setupReactiveComponents()
    }
    
    func showLeftMenuButtonTapped() {
        coordinatorDelegate?.didTapSideMenuButton()
    }
    
    // MARK: - Private funcs
    
    private func setupReactiveComponents() {
        context.services.locationService
            .locationObserver
            .observeValues { [weak self] location in
                self?.changeCameraLocation(location: location.coordinate)
        }
    }
    
    private func changeCameraLocation(location: CLLocationCoordinate2D) {
        if initialCameraMove {
            initialCameraMove = false
            moveCameraToLocation.input.send(value: (location, initialZoomLevel))
//            GoogleMapsDirections.direction(fromOriginCoordinate: location.googleLocationCoordinate2D, toDestinationCoordinate: GoogleMapsDirections.LocationCoordinate2D(latitude: 40.865164, longitude: 45.133885)) { (response, error) in
//                print(response)
//            }
        }
    }
}

extension CLLocationCoordinate2D {
    var googleLocationCoordinate2D: GoogleMapsDirections.LocationCoordinate2D {
        GoogleMapsDirections.LocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
