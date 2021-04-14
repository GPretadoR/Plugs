//
//  BaseCellItemObject.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 11/6/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class BaseCellItemObject {
    var icon: UIImage?
    var titleText: String
    var additionalText: String?

    internal init(icon: UIImage? = nil, titleText: String, additionalText: String? = nil) {
        self.icon = icon
        self.titleText = titleText
        self.additionalText = additionalText
    }

    internal init(icon: UIImage? = nil, titleText: String) {
        self.icon = icon
        self.titleText = titleText
        self.additionalText = nil
    }

    convenience init(titleText: String) {
        self.init(icon: nil, titleText: titleText, additionalText: nil)
    }
}
