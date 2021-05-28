//
//  FAQViewViewModel.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import ReactiveSwift

protocol FAQViewCoordinatorDelegate: AnyObject {
    func didTapCloseButton()
}

class FAQViewViewModel: BaseViewModel {

    weak var coordinatorDelegate: FAQViewCoordinatorDelegate?
    private let context: Context
    
    var faqDataModel = MutableProperty<[TableViewData]>([
        TableViewData(title: R.string.localizable.faqQuestion1TitleText.localized(), data: [R.string.localizable.faqQuestion1AnswerText.localized()]),
        TableViewData(title: R.string.localizable.faqQuestion2TitleText.localized(), data: [R.string.localizable.faqQuestion2AnswerText.localized()]),
        TableViewData(title: R.string.localizable.faqQuestion3TitleText.localized(), data: [R.string.localizable.faqQuestion3AnswerText.localized()]),
        TableViewData(title: R.string.localizable.faqQuestion4TitleText.localized(), data: [R.string.localizable.faqQuestion4AnswerText.localized()]),
        TableViewData(title: R.string.localizable.faqQuestion5TitleText.localized(), data: [R.string.localizable.faqQuestion5AnswerText.localized()])
    ])
    
    init(context: Context, coordinatorDelegate: FAQViewCoordinatorDelegate) {
        self.context = context
        self.coordinatorDelegate = coordinatorDelegate
        super.init()
    }
    
    func didTapCloseButton() {
        coordinatorDelegate?.didTapCloseButton()
    }
}

struct TableViewData {
    let title: String
    var isExpanded: Bool = false
    var data: [String]
    
    init(title: String, data: [String], isExpanded: Bool = false) {
        self.title = title
        self.data = data
        self.isExpanded = isExpanded
    }
}
