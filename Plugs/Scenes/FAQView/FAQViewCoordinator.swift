//
//  FAQViewCoordinator.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class FAQViewCoordinator: BaseCoordinator {

    init(coordinator: BaseCoordinator) {
        super.init(coordinator: coordinator, viewController: FAQViewController())
        guard let viewController = controller as? FAQViewController else { return }
        guard let context = coordinator.context else { return }
        let viewModel = FAQViewViewModel(context: context, coordinatorDelegate: self)
        viewController.viewModel = viewModel
    }

    override func start() {
        parentCoordinator?.present(self, animated: true)
    }
}

extension FAQViewCoordinator: Presentable {
    func present() -> UIViewController {
        let navigationController = BaseNavigationController(rootViewController: controller as? FAQViewController ?? FAQViewController())
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }
    
}

extension FAQViewCoordinator: FAQViewCoordinatorDelegate {
    func didTapCloseButton() {
        dismissModal(animated: true)
    }
}
