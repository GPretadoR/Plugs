//
//  MainViewCoordinator.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/27/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class MainViewCoordinator: BaseCoordinator {
    private let window: UIWindow
    
    private var leftMenuCoordinator: LeftMenuViewCoordinator?

    init(context: Context, window: UIWindow) {
        self.window = window
        let viewController = MainViewController()
        super.init(context: context, root: viewController)
        let viewModel = MainViewViewModel(context: context, coordinatorDelegate: self)
        viewController.viewModel = viewModel
    }
    
    override func start() {
        guard let rootViewController = controller else { return }
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = .fullScreen        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension MainViewCoordinator: MainViewCoordinatorDelegate {
    func didTapSideMenuButton() {
        if leftMenuCoordinator == nil {
            leftMenuCoordinator = LeftMenuViewCoordinator(coordinator: self)
            if let leftMenu = leftMenuCoordinator {
                addChildCoordinator(leftMenu)
                leftMenu.start()
            }
        } else {
            leftMenuCoordinator?.start()
        }
    }
    
    func openDetailsPage(charger: ChargerStationObject) {
        guard let navController = controller?.navigationController as? BaseNavigationController else { return }
        let navCoordinator = NavCoordinator(context: context ?? Current.context, root: navController)
        let chargersDetailCoordinator = ChargerDetailsViewCoordinator(coordinator: navCoordinator,
                                                                      chargerStation: charger)
        addChildCoordinator(chargersDetailCoordinator)
        chargersDetailCoordinator.start()
    }
}
