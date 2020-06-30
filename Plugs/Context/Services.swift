//
//  Services.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 2/29/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation

class Services {
    
    let databaseServiceProvider = DatabaseServiceProvider(persistentContainerName: AppEnvironment.current.persistentStoreName)
    let locationService: LocationService
    let firestoreService = FirestoreManagementService(serviceProvider: FirebaseManagementServiceProvider())
    let chargerStationsManagementService: ChargerStationsManagementService
    
    init() {
        chargerStationsManagementService = ChargerStationsManagementService(dbProvider: databaseServiceProvider,
                                                                            fireStoreService: firestoreService)
        locationService = LocationService(serviceProvider: LocationServiceProvider())
    }
}
