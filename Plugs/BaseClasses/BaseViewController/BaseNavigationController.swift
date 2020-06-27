//
//  BaseNavigationController.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 5/26/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

protocol BaseNavigationControllerDelegate: class {
    func didPopViewController(viewController: UIViewController?)
    func didPopToRootViewController(viewControllers: [UIViewController])
}

class BaseNavigationController: UINavigationController {

    /// Use this delegate to subscribe to popViewController and popToRootViewController actions. In the implementation remove all child coordinators. Remember implement delegate methods in parent coordinator of popped view controller.
    weak var baseDelegate: BaseNavigationControllerDelegate?

    override func popViewController(animated: Bool) -> UIViewController? {
        let poppedVC = super.popViewController(animated: animated)
        baseDelegate?.didPopViewController(viewController: poppedVC)
        return poppedVC
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let poppedVCs = super.popToRootViewController(animated: animated)
        baseDelegate?.didPopToRootViewController(viewControllers: poppedVCs ?? [])
        return poppedVCs
    }
}
