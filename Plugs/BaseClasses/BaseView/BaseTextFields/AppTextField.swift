//
//  AppTextField.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/13/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class AppTextField: BaseTextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func style(for style: TextsStyles) {
        let textStyle = TextsStyles(style: style)?.style
        self.font = textStyle?.font
        self.textColor = textStyle?.textColor
    }

    func style(for style: TextsStyles, color: UIColor) {
        let textStyle = TextsStyles(style: style)?.style
        self.font = textStyle?.font
        self.textColor = color
    }
}
