//
//  ChargerStationObject.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/29/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import FirebaseFirestore.FIRGeoPoint
import CoreLocation

struct ChargerStationObject {
    var region: String?
    var city: String?
    var name: String?
    var coordinates: GeoPoint?
    var plugType: String?
    var accessType: String?
    var notes: String?
    var photoURL: String?
    var geoRegion: GeoRegionObject?
    
    init(with dict: [String: Any]) {
        self.region = dict["region"] as? String
        self.city = dict["city"] as? String
        self.name = dict["name"] as? String
        self.coordinates = dict["coordinates"] as? GeoPoint
        self.plugType = dict["plugType"] as? String
        self.accessType = dict["accessType"] as? String
        self.notes = dict["notes"] as? String
        self.photoURL = dict["photoURL"] as? String
        self.geoRegion = GeoRegionObject(with: dict["geoRegion"] as? [String: Any]) 
    }
    
    /// Core Data ChargerStation to ChargerStationObject
    init(chargerObject: ChargerStation) {
        self.region = chargerObject.region
        self.city = chargerObject.city
        self.name = chargerObject.name
        self.coordinates = GeoPoint(latitude: chargerObject.latitude, longitude: chargerObject.longitude)
        self.plugType = chargerObject.plugType
        self.accessType = chargerObject.accessType
        self.notes = chargerObject.notes
        self.photoURL = chargerObject.photoURL
    }
}

extension ChargerStationObject {
    var coordinate2D: CLLocationCoordinate2D? {
        get {
            guard let coordinate = coordinates else { return nil }
            return CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
        set {
            guard let lat = newValue?.latitude,
                let lng = newValue?.longitude else { return }
            coordinates = GeoPoint(latitude: lat, longitude: lng)
        }
    }
}
