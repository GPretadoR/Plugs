//
//  ChargerStationAnnotation.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/29/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import MapKit
import CoreLocation

class ChargerStationAnnotation: NSObject, MKAnnotation {
    
    var region: String?
    var city: String?
    var name: String?
    var coordinates: [Double]?
    var plugType: String?
    var accessType: String?
    var notes: String?
    var photoURL: String?
    
    init(chargerStationObject: ChargerStationObject) {
        self.region = chargerStationObject.region
        self.city = chargerStationObject.city
        self.name = chargerStationObject.name
        self.coordinates = chargerStationObject.coordinates
        self.plugType = chargerStationObject.plugType
        self.accessType = chargerStationObject.accessType
        self.notes = chargerStationObject.notes
        self.photoURL = chargerStationObject.photoURL
    }
    
    init(region: String?,
         city: String?,
         name: String?,
         coordinates: [Double]?,
         plugType: String?,
         accessType: String?,
         notes: String?,
         photoURL: String?) {
        self.region = region
        self.city = city
        self.name = name
        self.coordinates = coordinates
        self.plugType = plugType
        self.accessType = accessType
        self.notes = notes
        self.photoURL = photoURL
        super.init()
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return city
    }
    
    var coordinate: CLLocationCoordinate2D {
        guard let coordinate = coordinates else { return CLLocationCoordinate2D() }
        return CLLocationCoordinate2D(latitude: coordinate[0], longitude: coordinate[1])
    }
}
