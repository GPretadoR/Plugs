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
    
    init(context: Context, window: UIWindow) {
        self.window = window
        let viewController = R.storyboard.main.mainViewController()
        super.init(context: context, root: viewController)
        let viewModel = MainViewViewModel(context: context, coordinatorDelegate: self)
        viewController?.viewModel = viewModel
    }
    
    override func start() {
        guard let rootViewController = controller else { return }
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}

extension MainViewCoordinator: MainViewCoordinatorDelegate {
    
}
