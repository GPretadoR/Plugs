//
//  BaseCoordinator.swift
//  MVVM-C-Networking
//
//  Created by Garnik Ghazaryan on 1/22/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class BaseCoordinator: Coordinator {

    var context: Context?

    weak var parentCoordinator: BaseCoordinator?
    var childCoordinators: [BaseCoordinator] = []

    var controller: UIViewController?

    init() {}

    init(context: Context, root controller: UIViewController?) {
        self.context = context
        self.controller = controller
    }

    init(coordinator: BaseCoordinator, viewController: BaseViewController) {
        context = coordinator.context
        controller = viewController
    }

    func start() {}

    func changeCoordinatorsRoot(coordinator: BaseCoordinator) {
        var currentCoordinator = self
        while currentCoordinator.parentCoordinator != nil {
            currentCoordinator.removeAllChildCoordinators()
            if let parentCoordinator = currentCoordinator.parentCoordinator {
                currentCoordinator = parentCoordinator
            } else {
                break
            }
        }
        currentCoordinator.removeAllChildCoordinators()
        currentCoordinator.addChildCoordinator(coordinator)
    }

    func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)? = nil) {
        let vc = presentable.present()
        controller?.present(vc, animated: animated, completion: completion)
    }

    func dismissModal(animated: Bool, completion: (() -> Void)? = nil) {
        guard let controller = controller else { return }
        controller.dismiss(animated: animated, completion: completion)
        parentCoordinator?.removeAllChildCoordinators()
    }

    func dismissModal(animated: Bool, childCoordinator: BaseCoordinator, completion: (() -> Void)? = nil) {
        guard let controller = controller else { return }
        controller.dismiss(animated: animated, completion: completion)
        parentCoordinator?.removeChildCoordinator(childCoordinator)
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        guard let controller = controller else { return }

        var currentCoordinator = self
        while controller == currentCoordinator.controller {
            currentCoordinator.removeAllChildCoordinators()
            if let parentCoordinator = currentCoordinator.parentCoordinator {
                currentCoordinator = parentCoordinator
            } else {
                break
            }
        }
        currentCoordinator.removeAllChildCoordinators()

        DispatchQueue.main.async {
            controller.dismiss(animated: animated, completion: completion)
        }

        let childrens = controller.children
        childrens.forEach { vc in
            vc.removeFromParent()
        }
    }

    func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }

    func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }

    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }

    func transaction(with completion: (() -> Void)?, action: () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        action()
        CATransaction.commit()
    }
}

extension BaseCoordinator: Equatable {
    static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }
}
