//
//  AboutUsViewViewModel.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation

protocol AboutUsViewCoordinatorDelegate: AnyObject {
    func didTapCloseButton()
    func openPlugAM()
}

class AboutUsViewViewModel: BaseViewModel {

    weak var coordinatorDelegate: AboutUsViewCoordinatorDelegate?
    private let context: Context

    init(context: Context, coordinatorDelegate: AboutUsViewCoordinatorDelegate) {
        self.context = context
        self.coordinatorDelegate = coordinatorDelegate
        super.init()
    }
    
    func didTapCloseButton() {
        coordinatorDelegate?.didTapCloseButton()
    }
    
    func didTapPlugAmLink() {
        coordinatorDelegate?.openPlugAM()
    }
}
