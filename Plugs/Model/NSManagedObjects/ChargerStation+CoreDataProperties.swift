//
//  ChargerStation+CoreDataProperties.swift
//  
//
//  Created by Garnik Ghazaryan on 6/28/20.
//
//

import Foundation
import CoreData

extension ChargerStation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChargerStation> {
        return NSFetchRequest<ChargerStation>(entityName: "ChargerStation")
    }

    @NSManaged public var region: String?
    @NSManaged public var city: String?
    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var plugType: String?
    @NSManaged public var accessType: String?
    @NSManaged public var notes: String?
    @NSManaged public var photoURL: String?

}
