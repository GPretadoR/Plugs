//
//  GeoPointObject.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 21.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import FirebaseFirestore.FIRGeoPoint

//: ### Defining the protocols
protocol JSONRepresentable {
    var JSONRepresentation: Any { get }
}
protocol JSONSerializable: JSONRepresentable {}
extension JSONSerializable {
    func toJSON() -> String? {
        let representation = JSONRepresentation

        guard JSONSerialization.isValidJSONObject(representation) else {
            print("Invalid JSON Representation")
            return nil
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
}

extension GeoPoint: CustomReflectable {
    public var customMirror: Mirror {
        Mirror(self, children: ["latitude": latitude, "longitude": longitude])
    }
}

//: ### Implementing the functionality through protocol extensions
extension JSONSerializable {
    var JSONRepresentation: Any {
        var representation = [String: Any]()
        for case let (label?, value) in Mirror(reflecting: self).children {

            switch value {

            case let value as [String: Any]:
                representation[label] = value as Any

            case let value as [Any]:
                if let val = value as? [JSONSerializable] {
                    representation[label] = val.map({ $0.JSONRepresentation as AnyObject }) as AnyObject
                } else {
                    representation[label] = value as Any
                }

            case let value:
                representation[label] = value as Any
            }
        }
        return representation as Any
    }
}
