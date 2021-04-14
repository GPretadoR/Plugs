//
//  BaseView.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/4/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class BaseView: UIView {

    init() {
        super.init(frame: .zero)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {}

    var hasShadow: Bool = false {
        didSet {
            if self.hasShadow {
                self.addCornerRadiusAndShadow(cornerRadius: layer.cornerRadius,
                                              shadowColor: .black,
                                              shadowOffset: CGSize(width: 0.0, height: 6.0),
                                              shadowRadius: layer.cornerRadius,
                                              shadowOpacity: 0.25)
            }
        }
    }
}
