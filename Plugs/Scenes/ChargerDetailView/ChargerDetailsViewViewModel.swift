//
//  ChargerDetailsViewViewModel.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol ChargerDetailViewCoordinatorDelegate: class {
    func didTapSideMenuButton()
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
    
}
