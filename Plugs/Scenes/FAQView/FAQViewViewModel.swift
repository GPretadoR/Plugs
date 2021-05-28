//
//  FAQViewViewModel.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation

protocol FAQViewCoordinatorDelegate: AnyObject {
    func didTapCloseButton()
}

class FAQViewViewModel: BaseViewModel {

    weak var coordinatorDelegate: FAQViewCoordinatorDelegate?
    private let context: Context

    init(context: Context, coordinatorDelegate: FAQViewCoordinatorDelegate) {
        self.context = context
        self.coordinatorDelegate = coordinatorDelegate
        super.init()
    }
    
    func didTapCloseButton() {
        coordinatorDelegate?.didTapCloseButton()
    }
}
