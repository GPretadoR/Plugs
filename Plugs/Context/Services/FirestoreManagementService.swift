//
//  FirestoreManagementService.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/28/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import ReactiveSwift

class FirestoreManagementService {
    
    let serviceProvider: FirebaseManagementServiceProvider
    
    init(serviceProvider: FirebaseManagementServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchData(collection: String) -> SignalProducer<[[String: Any]], Error> {
        return serviceProvider.getData(from: collection)
    }
}
