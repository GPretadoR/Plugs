//
//  MapViewViewModel.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 12/14/18.
//  Copyright © 2018 Garnik Ghazaryan. All rights reserved.
//

import GoogleMaps.GMSMarker
import ReactiveSwift

class MapViewViewModel: BaseViewModel {
    
    var markers = MutableProperty<[GMSMarker]>([])
    
    func configure() {
        setupReactiveComponents()
    }

    private func setupReactiveComponents() {
        Current.context.services.chargerStationsManagementService
            .chargerStations
            .signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] chargerStations in
                self?.createMarkers(chargerStations: chargerStations)
        }
    }

    func createMarkers(chargerStations: [ChargerStationObject]) {
        var markers: [GMSMarker] = []
        chargerStations.forEach { chargerStation in
            let marker = GMSMarker()
            marker.position = chargerStation.coordinate2D ?? .init()
            marker.title = chargerStation.name
            marker.snippet = chargerStation.city
            markers.append(marker)
        }
        self.markers.value = markers
    }
}
