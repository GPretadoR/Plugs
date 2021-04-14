//
//  DatabaseServices.swift
//  RakutenShop
//
//  Created by Garnik Ghazaryan on 2/18/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import CoreData
import ReactiveSwift

protocol DatabaseServices {
    
    associatedtype T
    associatedtype Output
    
    func perform(completion: @escaping (NSManagedObjectContext) throws -> Void) -> SignalProducer<Bool, Error>
    func performUnique(entityName: String,
                       uniqueKeyValue: [String: String],
                       completion: @escaping (NSManagedObjectContext) throws -> Void) -> SignalProducer<Bool, Error>
    func fetch<Output>(objectType: Output.Type) -> SignalProducer<[Output], Error>
}
