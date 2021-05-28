//
//  ChargerStationsManagementService.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/28/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import ReactiveSwift
import Firebase

class ChargerStationsManagementService {
    
    var chargerStations = MutableProperty<[ChargerStationObject]>([])
    
    private let dbProvider: DatabaseServiceProvider
    private let fireStoreService: FirestoreManagementService
    
    private let scheduler = QueueScheduler()
    
    init(dbProvider: DatabaseServiceProvider, fireStoreService: FirestoreManagementService) {
        self.dbProvider = dbProvider
        self.fireStoreService = fireStoreService
        self.configure()
    }

    private func configure() {
        UIApplication.reactive
            .didBecomeActive
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] in
//                self?.fetchFromFirebase()
        }
    }
    
    func fetchFromFirebase() {
        fireStoreService.fetchData(collection: "stations").observe(on: scheduler)
            .on(value: { [weak self] data in
                let chargerStations = data.map { ChargerStationObject(with: $0) }
                self?.chargerStations.value = chargerStations
            }).start()
    }
    
    private func saveToCoreData(chargerStations: [ChargerStationObject]) {
        chargerStations.forEach { chargerStation in
            if let name = chargerStation.name {
                let chargerModel = ChargerStation(context: dbProvider.context)
                chargerModel.region = chargerStation.region
                chargerModel.city = chargerStation.city
                chargerModel.name = chargerStation.name
                chargerModel.latitude = chargerStation.coordinate2D?.latitude ?? 0
                chargerModel.longitude = chargerStation.coordinate2D?.longitude ?? 0
                chargerModel.plugType = chargerStation.plugType
                chargerModel.accessType = chargerStation.accessType
                chargerModel.notes = chargerStation.notes
                chargerModel.photoURL = chargerStation.photoURL
                dbProvider.syncSaveUnique(entityName: "ChargerStation", uniqueKeyValue: ["name": name])
            }
        }
    }
    
    private func getChargers() {
        self.dbProvider.fetch(objectType: ChargerStation.self)
            .observe(on: self.scheduler)
            .on(failed: { (error) in
                print(error)
            },
            value: { [weak self] (stations) in
                let stationObjects = stations.compactMap { (station) -> ChargerStationObject? in
                    ChargerStationObject(chargerObject: station)
                }
                self?.chargerStations.value = stationObjects
            }).start()
    }
}
