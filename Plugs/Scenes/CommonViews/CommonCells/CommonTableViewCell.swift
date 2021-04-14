//
//  LeftMenuTableViewCell.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/1/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit
import SnapKit

class CommonTableViewCell: BaseView {

    var iconImageView = AppImageView {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
    }
    var titleTextLabel = AppLabel {
        $0.style(textStyle: .bold14px, color: R.color.black()!)
    }

    var accessoryView: UIView? {
        didSet {
            setupAccessoryView()
        }
    }

    override func setupView() {
        addSubview(iconImageView)
        addSubview(titleTextLabel)

        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(13)
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.top.equalToSuperview()
            make.bottom.equalTo(1).priority(250)
        }

        titleTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
            make.centerY.equalTo(iconImageView.snp.centerY)
        }
    }

    func configure(icon: UIImage?, titleText: String) {
        configure(icon: icon, titleText: titleText, additionalText: nil)
    }

    func configure(icon: UIImage?, titleText: String, additionalText: String?) {
        iconImageView.image = icon
        titleTextLabel.text = titleText.uppercased()
        if icon == nil {
            iconImageView.snp.updateConstraints { make in
                make.width.equalTo(0)
            }
            if additionalText == nil {
                titleTextLabel.snp.remakeConstraints { make in
                    make.leading.equalTo(iconImageView.snp.trailing).offset(15)
                    make.centerY.equalToSuperview()
                }
            }
        }
    }

    func configure(titleText: String) {
        configure(icon: nil, titleText: titleText)
    }

    private func setupAccessoryView() {
        guard let accessoryView = accessoryView else { return }
        addSubview(accessoryView)

        accessoryView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-21)
            make.leading.equalTo(titleTextLabel.snp.trailing).offset(10)
        }
    }
}
