//
//  FirestoreManagementService.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/28/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import FirebaseFirestore.FIRGeoPoint
import ReactiveSwift

class FirestoreManagementService {
    
    let serviceProvider: FirebaseManagementServiceProvider
    
    init(serviceProvider: FirebaseManagementServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchData(collection: String) -> SignalProducer<[[String: Any]], Error> {
        return serviceProvider.getData(from: collection)
    }
    
    func sendData(fields: [String: Any]) -> SignalProducer<String, Error> {
        return serviceProvider.addData(to: "visits", fields: fields)
    }
    
    func updateData(of collection: String, in document: String, with fields: [String: Any]) -> SignalProducer<String, Error> {
        return serviceProvider.updateData(to: collection, with: document, fields: fields)
    }
}
