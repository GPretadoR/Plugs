//
//  DonorsViewViewModel.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation

protocol DonorsViewCoordinatorDelegate: AnyObject {
    func didTapCloseButton()
}

class DonorsViewViewModel: BaseViewModel {

    weak var coordinatorDelegate: DonorsViewCoordinatorDelegate?
    private let context: Context

    init(context: Context, coordinatorDelegate: DonorsViewCoordinatorDelegate) {
        self.context = context
        self.coordinatorDelegate = coordinatorDelegate
        super.init()
    }
    
    func didTapCloseButton() {
        coordinatorDelegate?.didTapCloseButton()
    }
}
