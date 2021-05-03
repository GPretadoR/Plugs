//
//  ChargerDetailsViewViewModel.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import CoreLocation
import Foundation
import ReactiveSwift

protocol ChargerDetailViewCoordinatorDelegate: class {
    func didTapSideMenuButton()
    func openDirections(to coordinate: CLLocationCoordinate2D)
}

class ChargerDetailsViewViewModel: BaseViewModel {
    
    let charger = MutableProperty<ChargerStationObject?>(nil)
    
    private let chargerStation: ChargerStationObject
    
    weak var coordinatorDelegate: ChargerDetailViewCoordinatorDelegate?
    private let context: Context
        
    init(context: Context,
         coordinatorDelegate: ChargerDetailViewCoordinatorDelegate,
         chargerStation: ChargerStationObject) {
        self.context = context
        self.coordinatorDelegate = coordinatorDelegate
        self.chargerStation = chargerStation
        super.init()
    }

    func viewDidLoadTriggered() {
        self.charger.value = chargerStation
    }
    
    func getChargerImage(urlString: String) -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        let data = try? Data(contentsOf: url)
        return UIImage(data: data ?? Data())
    }
    
    func didTapGetDirectionButton() {
        coordinatorDelegate?.openDirections(to: charger.value?.coordinate2D ?? CLLocationCoordinate2D())
    }
}
