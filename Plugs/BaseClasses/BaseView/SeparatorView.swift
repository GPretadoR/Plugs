//
//  SeparatorView.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/12/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit
import SnapKit

enum SeparatorViewOrientation {
    case horizontal
    case vertical
}

class SeparatorView: BaseView {

    var orientation: SeparatorViewOrientation = .horizontal {
        didSet {
            self.snp.makeConstraints { make in
                switch orientation {
                case .horizontal:
                    make.height.equalTo(1)
                case .vertical:
                    make.width.equalTo(1)
                }
            }
        }
    }

    override func setupView() {
        alpha = 0.13
        backgroundColor = .gray
    }
}
