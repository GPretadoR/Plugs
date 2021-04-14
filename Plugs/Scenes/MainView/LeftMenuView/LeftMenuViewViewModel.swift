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
    
    let menuItems = MutableProperty<[LeftMenuCellItemObject]>(
        [LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "ic_back"),
                                titleText: R.string.localizable.leftMenuItemAboutusText.localized()),
         LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "ic_back"),
                                titleText: R.string.localizable.leftMenuItemDonorsText.localized()),
         LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "ic_back"),
                                titleText: R.string.localizable.leftMenuItemFaqText.localized()),
         LeftMenuCellItemObject(icon: #imageLiteral(resourceName: "ic_back"),
                                titleText: R.string.localizable.leftMenuItemAddstationText.localized())]
    )

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
    
    }

    // MARK: - Private Functions

}

extension LeftMenuViewViewModel {
    class LeftMenuCellItemObject: BaseCellItemObject {}
}
