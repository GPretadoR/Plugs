//
//  ChargerDetailsViewCoordinator.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import CoreLocation
import Foundation
import UIKit

class ChargerDetailsViewCoordinator: NavCoordinator {

    init(coordinator: NavCoordinator, chargerStation: ChargerStationObject) {
        super.init(coordinator: coordinator, viewController: ChargerDetailsViewController())
        guard let viewController = controller as? ChargerDetailsViewController else { return }
        guard let context = coordinator.context else { return }
        let viewModel = ChargerDetailsViewViewModel(context: context,
                                                    coordinatorDelegate: self,
                                                    chargerStation: chargerStation)
        viewController.viewModel = viewModel
    }

    override func start() {
        guard let viewController = controller as? ChargerDetailsViewController else { return }        
        push(viewController, animated: true)
    }
}

extension ChargerDetailsViewCoordinator: ChargerDetailViewCoordinatorDelegate {
    func didTapSideMenuButton() {
        
    }
    
    func openDirections(to coordinate: CLLocationCoordinate2D) {
        let stringURL = "comgooglemaps://"
        let lat = coordinate.latitude
        let lng = coordinate.longitude

        if UIApplication.shared.canOpenURL(URL(string: stringURL)!) {
            if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(lat),\(lng)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            if let destinationURL = URL(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(lng)&directionsmode=driving") {
                UIApplication.shared.open(destinationURL, options: [:], completionHandler: nil)
            }
        }
        
    }
}
