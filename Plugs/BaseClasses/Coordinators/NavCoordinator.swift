//
//  NavCoordinator.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 5/25/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class NavCoordinator: BaseCoordinator {

    private(set) var navigationController: BaseNavigationController
    weak var navigationPresentingController: UIViewController?

    init(context: Context, root controller: BaseNavigationController) {
        navigationController = controller
        super.init(context: context, root: controller)
    }

    init(coordinator: NavCoordinator, viewController: BaseViewController) {
        navigationController = coordinator.navigationController
        super.init(coordinator: coordinator, viewController: viewController)
    }

    // MARK: - Overrides

    // MARK: -

    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            navigationController.coordinator = self
            navigationController.pushViewController(viewController, animated: animated)
            navigationPresentingController = viewController
        }
    }

    func replace(with viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            navigationController.setViewControllers(
                navigationController.viewControllers.dropLast() + [viewController],
                animated: animated)
            navigationPresentingController = viewController
        }
    }

    func set(_ viewControllers: [UIViewController], animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            navigationController.setViewControllers(
                viewControllers,
                animated: animated)
            navigationPresentingController = viewControllers.last
        }
    }

    func pop(animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            _ = navigationController.popViewController(animated: animated)
            parentCoordinator?.removeChildCoordinator(self)
            navigationController.coordinator = nil
        }
    }

    func pop(to viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        transaction(with: completion) {
            navigationController.popToViewController(viewController, animated: animated)
            var currentCoordinator = self
            while viewController != currentCoordinator.navigationPresentingController {
                currentCoordinator.removeAllChildCoordinators()
                if let parentCoordinator = currentCoordinator.parentCoordinator as? NavCoordinator {
                    currentCoordinator = parentCoordinator
                }
            }
            currentCoordinator.removeAllChildCoordinators()
            navigationController.coordinator = nil
        }
    }

    func popControllerToType<T>() -> T? {
        for controller in navigationController.viewControllers {
            if let theController = controller as? T {
                navigationController.popToViewController(controller, animated: false)
                navigationController.coordinator = nil
                return theController
            }
        }
        return nil
    }

    func findParentCoordinatorByType<T>() -> T? {
        var baseCoordinator = parentCoordinator

        while baseCoordinator != nil {
            if let matchedCoordinator = baseCoordinator as? T {
                return matchedCoordinator
            }
            baseCoordinator = baseCoordinator?.parentCoordinator
        }
        return nil
    }

    func popToRoot(animated: Bool, completion: (() -> Void)?) {
        transaction(with: completion) {
            navigationController.popToRootViewController(animated: animated)
            navigationController.coordinator = nil
        }
    }
}
