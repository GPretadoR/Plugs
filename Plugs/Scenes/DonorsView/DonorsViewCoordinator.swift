//
//  DonorsViewCoordinator.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class DonorsViewCoordinator: BaseCoordinator {

    init(coordinator: BaseCoordinator) {
        super.init(coordinator: coordinator, viewController: DonorsViewController())
        guard let viewController = controller as? DonorsViewController else { return }
        guard let context = coordinator.context else { return }
        let viewModel = DonorsViewViewModel(context: context, coordinatorDelegate: self)
        viewController.viewModel = viewModel
    }

    override func start() {
        parentCoordinator?.present(self, animated: true)
    }
}

extension DonorsViewCoordinator: Presentable {
    func present() -> UIViewController {
        let navigationController = BaseNavigationController(rootViewController: controller as? DonorsViewController ?? DonorsViewController())
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }
    
}

extension DonorsViewCoordinator: DonorsViewCoordinatorDelegate {
    func didTapCloseButton() {
        dismissModal(animated: true)
    }
    
    func openPlugAM() {
        guard let url = URL(string: AppEnvironment.current.facebookURL) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
