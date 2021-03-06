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
                self?.fetchFromFirebase()
        }
    }
    
    private func fetchFromFirebase() {
        fireStoreService.fetchData(collection: "stations").observe(on: scheduler)
            .on { [weak self] data in
                var chargerStations: [ChargerStationObject] = []
                data.forEach { (chargerStation) in
                    var station = chargerStation
                    guard let geoPoint = station["coordinates"] as? GeoPoint else { return }
                    let coordinatesArray = [geoPoint.latitude, geoPoint.longitude]
                    station["coordinates"] = coordinatesArray
                    let decoder = JSONDecoder()
                    do {
                        let stationData = try JSONSerialization.data(withJSONObject: station, options: .prettyPrinted)
                        let stationObject = try decoder.decode(ChargerStationObject.self, from: stationData)
                        chargerStations.append(stationObject)
                    } catch {
                        print(error)
                    }
                }
                self?.saveToCoreData(chargerStations: chargerStations)

        }.on(completed: { [weak self] in
            self?.getChargers()
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
            }, value: { [weak self] (stations) in
                let stationObjects = stations.compactMap { (station) -> ChargerStationObject? in
                    ChargerStationObject(chargerObject: station)
                }
                self?.chargerStations.value = stationObjects
            }).start()
    }
}
