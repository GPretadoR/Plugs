//
//  FirebaseManagementServicees.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/28/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//
import ReactiveSwift

protocol FirebaseManagementServices {
    func getData(from collection: String) -> SignalProducer<[[String: Any]], Error>
}
