//
//  GeoRegionObject.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 21.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import CoreLocation
import FirebaseFirestore.FIRGeoPoint

struct GeoRegionObject {
    internal init(identifier: String?, coordinates: GeoPoint? = nil, radius: Double?) {
        self.identifier = identifier
        self.coordinates = coordinates
        self.radius = radius
    }
    
    let identifier: String?
    var coordinates: GeoPoint?
    let radius: Double?
    
    init?(with dict: [String: Any]?) {
        if let dict = dict {
            self.identifier = dict["identifier"] as? String
            self.coordinates = dict["coordinates"] as? GeoPoint
            self.radius = dict["radius"] as? Double
        } else {
            return nil
        }
    }
}

extension GeoRegionObject {
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
