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
        window.rootViewController = rootViewController
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
}
