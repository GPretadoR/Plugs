//
//  ChargerDetailsViewCoordinator.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation

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
}
