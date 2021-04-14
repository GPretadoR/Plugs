//
//  ChargerStationObject.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/29/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Firebase
import CoreLocation

struct ChargerStationObject: Codable {
    var region: String?
    var city: String?
    var name: String?
    var coordinates: [Double]?
    var plugType: String?
    var accessType: String?
    var notes: String?
    var photoURL: String?
    
    /// Core Data ChargerStation to ChargerStationObject
    init(chargerObject: ChargerStation) {
        self.region = chargerObject.region
        self.city = chargerObject.city
        self.name = chargerObject.name
        self.coordinates = [chargerObject.latitude, chargerObject.longitude]
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
            return CLLocationCoordinate2D(latitude: coordinate[0], longitude: coordinate[1])
        }
        set {
            guard let lat = newValue?.latitude,
                let lng = newValue?.longitude else { return }
            coordinates = [lat, lng]
        }
    }
}
