//
//  MapViewViewModel.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 12/14/18.
//  Copyright © 2018 Garnik Ghazaryan. All rights reserved.
//

import GoogleMaps.GMSMarker
import ReactiveSwift

class MapViewViewModel: BaseViewModel {
    
    var markers = MutableProperty<[ChargerMarker]>([])
    
    func configure(with markers: [ChargerMarker]) {
        self.markers.value = markers
    }
}
