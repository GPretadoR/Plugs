//
//  LeftMenuViewCoordinator.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/1/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit
import SideMenu

class LeftMenuViewCoordinator: BaseCoordinator {

    init(coordinator: BaseCoordinator) {
        super.init(coordinator: coordinator, viewController: LeftMenuViewController())
        guard let context = coordinator.context else { return }
        guard let viewController = controller as? LeftMenuViewController else { return }
        let viewModel = LeftMenuViewViewModel(context: context, coordinatorDelegate: self)
        viewController.viewModel = viewModel
    }

    private func makeSideMenuSettings() -> SideMenuSettings {
        let sideMenuPresentationStyle: SideMenuPresentationStyle = .menuSlideIn
        sideMenuPresentationStyle.backgroundColor = UIColor.clear
        sideMenuPresentationStyle.presentingEndAlpha = 0.5

        var settings = SideMenuSettings()
        settings.presentationStyle = sideMenuPresentationStyle
        settings.statusBarEndAlpha = 0
        settings.menuWidth = 288
        settings.dismissWhenBackgrounded = true
        settings.dismissOnPush = true
        settings.dismissOnPresent = true
        return settings
    }

    override func start() {
        parentCoordinator?.present(self, animated: true, completion: nil)
    }
}

extension LeftMenuViewCoordinator: Presentable {
    func present() -> UIViewController {
        if let leftMenuVC = controller as? LeftMenuViewController {
            leftMenuVC.modalTransitionStyle = .coverVertical
            leftMenuVC.modalPresentationStyle = .overCurrentContext
            let menu = SideMenuNavigationController(rootViewController: leftMenuVC)
            menu.sideMenuDelegate = self
            leftMenuVC.navigationController?.isNavigationBarHidden = true
            menu.leftSide = true
            menu.settings = makeSideMenuSettings()
            return menu
        }
        return SideMenuNavigationController(rootViewController: LeftMenuViewController())
    }
}

extension LeftMenuViewCoordinator: LeftMenuViewCoordinatorDelegate {
    func didSelectCell(type: LeftMenuCellType) {
        handleCellTap(type: type)
    }

    func didTapProfileButton() {
    }

    private func showLoginView() {
    }

    private func handleCellTap(type: LeftMenuCellType) {
        switch type {
        case .aboutUs:
            let aboutUsCoordinator = AboutUsViewCoordinator(coordinator: self)
            addChildCoordinator(aboutUsCoordinator)
            aboutUsCoordinator.start()
        case .donors:
            let donorsCoordinator = DonorsViewCoordinator(coordinator: self)
            addChildCoordinator(donorsCoordinator)
            donorsCoordinator.start()
        case .faq:
            let faqCoordinator = FAQViewCoordinator(coordinator: self)
            addChildCoordinator(faqCoordinator)
            faqCoordinator.start()
        default:
            break
        }
    }
}

extension LeftMenuViewCoordinator: SideMenuNavigationControllerDelegate {
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        if childCoordinators.count == 0 {
            parentCoordinator?.removeChildCoordinator(self)
        }
    }
}
