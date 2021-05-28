//
//  AboutUsViewCoordinator.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class AboutUsViewCoordinator: BaseCoordinator {

    private weak var viewController: AboutUsViewController?

    init(coordinator: BaseCoordinator) {
        super.init(coordinator: coordinator, viewController: AboutUsViewController())
        guard let viewController = controller as? AboutUsViewController else { return }
        guard let context = coordinator.context else { return }
        let viewModel = AboutUsViewViewModel(context: context, coordinatorDelegate: self)
        viewController.viewModel = viewModel
    }

    override func start() {
        parentCoordinator?.present(self, animated: true)
    }

}

extension AboutUsViewCoordinator: Presentable {
    func present() -> UIViewController {
        let navigationController = BaseNavigationController(rootViewController: controller as? AboutUsViewController ?? AboutUsViewController())
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }
    
}

extension AboutUsViewCoordinator: AboutUsViewCoordinatorDelegate {
    func didTapCloseButton() {
        dismissModal(animated: true)
    }
}
