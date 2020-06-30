//
//  MainViewViewModel.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/27/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import ReactiveSwift
import MapKit

protocol MainViewCoordinatorDelegate: class {
    
}

class MainViewViewModel: BaseViewModel {
    
    weak var coordinatorDelegate: MainViewCoordinatorDelegate?
    private let context: Context
    
    var chargerStations = MutableProperty<[ChargerStationObject]>([])
    var mapAnnotations = MutableProperty<[MKAnnotation]>([])
    
    init(context: Context, coordinatorDelegate: MainViewCoordinatorDelegate) {
        self.context = context
        self.coordinatorDelegate = coordinatorDelegate
        super.init()
        setupReactiveComponents()
    }
    
    private func setupReactiveComponents() {
        context.services.chargerStationsManagementService
            .chargerStations
            .signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] chargerStations in
                self?.createMapAnnotations(chargerStations: chargerStations)
        }
    }
    
    private func createMapAnnotations(chargerStations: [ChargerStationObject]) {
        var annotation: [MKAnnotation] = []
        chargerStations.forEach { station in
            let stationAnnotation = ChargerStationAnnotation(chargerStationObject: station)
            annotation.append(stationAnnotation)
        }
        mapAnnotations.value = annotation
    }
}
