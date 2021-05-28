//
//  LeftMenuViewViewModel.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/1/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol LeftMenuViewCoordinatorDelegate: AnyObject {
    func didSelectCell(type: LeftMenuCellType)
    func didTapProfileButton()
    func closeToMainView()
}

enum LeftMenuCellType: Int {
    case aboutUs = 0
    case donors
    case faq
    case addStation
    case settings
}

class LeftMenuViewViewModel: BaseViewModel {

    weak var coordinatorDelegate: LeftMenuViewCoordinatorDelegate?
    private let context: Context
    
    let menuItems = MutableProperty<[LeftMenuCellItemObject]>(
        [
            LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "info"), titleText: R.string.localizable.leftMenuItemAboutusText.localized()),
            LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "battery-charging"), titleText: R.string.localizable.leftMenuItemDonorsText.localized()),
            LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "helpIcon"), titleText: R.string.localizable.leftMenuItemFaqText.localized()),
            LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "addCharger"), titleText: R.string.localizable.leftMenuItemAddstationText.localized())
        ]
    )

    let toggleState = MutableProperty<Bool>(true)
    
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
        toggleState.value = R.defaultLanguage == .en
    }
    
    func didSwitchToggle(isOn: Bool) {
        let language: R.Languages = isOn ? .en : .hy
        R.setDefaultLanguage(language)
        coordinatorDelegate?.closeToMainView()
    }

    // MARK: - Private Functions

}

extension LeftMenuViewViewModel {
    class LeftMenuCellItemObject: BaseCellItemObject {}
}
