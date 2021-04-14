//
//  LeftMenuViewViewModel.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/1/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol LeftMenuViewCoordinatorDelegate: class {
    func didSelectCell(type: LeftMenuCellType)
    func didTapProfileButton()
}

enum LeftMenuCellType: Int {
    case wallet = 0
    case rideHistory
    case howToRide
    case settings
    case helpAndSupport
    case reportAProblem
}

class LeftMenuViewViewModel: BaseViewModel {

    weak var coordinatorDelegate: LeftMenuViewCoordinatorDelegate?
    private let context: Context
    let menuItems = MutableProperty<[LeftMenuCellItemObject]>([LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "wallet"), titleText: R.string.common.walletText.localized()),
                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "history"), titleText: R.string.common.rideHistoryText.localized()),
                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "howtoride"), titleText: R.string.common.howToRideText.localized()),
                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "settings"), titleText: R.string.common.settingsText.localized()),
                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "help & support"), titleText: R.string.common.helpAndSupportText.localized()),
                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "help"), titleText: R.string.common.reportAProblemText.localized())])

    var profileName = MutableProperty<String?>(nil)
    var avatarImage = MutableProperty<UIImage?>(nil)
    var sponsorLogo2 = MutableProperty<UIImage?>(nil)

    init(context: Context, coordinatorDelegate: LeftMenuViewCoordinatorDelegate) {
        self.context = context
        self.coordinatorDelegate = coordinatorDelegate
        super.init()
    }

    func didSelectRow(at indexPath: IndexPath) {
        if let cellAtType = LeftMenuCellType(rawValue: indexPath.row) {
            coordinatorDelegate?.didSelectCell(type: cellAtType)
        }
    }

    func didTapProfileButton() {
        coordinatorDelegate?.didTapProfileButton()
    }

    func viewWillAppearTriggered() {
        let user = Current.loginSession.user
        profileName.value = user?.firstName

        avatarImage.value = context.services.userManagementService.avatarImage
        retrieveSponsorLogo2()
    }

    // MARK: - Private Functions

    private func retrieveSponsorLogo2() {
        if let logo = context.services.customizationManagementService.fleetImages.sponsorLogo2 {
            sponsorLogo2.value = logo
        } else {
            if let sponsorLogo2 = context.services.customizationManagementService.fleetImageNames.value.sponsorLogo2 {
                context.services.customizationManagementService
                    .fleetImages(name: sponsorLogo2)
                    .on(value: { [weak self] image in
                        self?.sponsorLogo2.value = image
                    }).start()
            }
        }
    }
}

extension LeftMenuViewViewModel {
    class LeftMenuCellItemObject: BaseCellItemObject {}
}

// enum LeftMenuCellType: Int {
//  case wallet = 0
//  case membership
//  case rideHistory
//  case howToRide
//  case rewards
//  case settings
//  case helpAndSupport
//  case reportAProblem
// }

//    let menuItems = MutableProperty<[LeftMenuCellItemObject]>([LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "wallet"), titleText: R.string.common.walletText.localized()),
//                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "membership"), titleText: R.string.common.membershipText.localized()),
//                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "history"), titleText: R.string.common.rideHistoryText.localized()),
//                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "howtoride"), titleText: R.string.common.howToRideText.localized()),
//                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "rewards"), titleText: R.string.common.rewardsText.localized()),
//                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "settings"), titleText: R.string.common.settingsText.localized()),
//                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "help & support"), titleText: R.string.common.helpAndSupportText.localized()),
//                                                               LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "help"), titleText: R.string.common.reportAProblemText.localized())])
