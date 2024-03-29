//
//  MapViewDelegate.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import GoogleMaps.GMSMarker

protocol MapViewDelegate: class {
    func didTapAtInfoWindow(of marker: ChargerMarker)
}
