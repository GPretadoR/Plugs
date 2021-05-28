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
        $0.contentMode = .center
    }
    var titleTextLabel = AppLabel {
        $0.style(textStyle: .regular15px, color: R.color.grayTextColor()!)
        $0.numberOfLines = 0
        $0.sizeToFit()
    }

    var accessoryView: UIView? {
        willSet {
            if newValue == nil {
                accessoryView?.removeFromSuperview()
            }
        }
        
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
            make.trailing.equalTo(-8)
        }
    }

    func configure(icon: UIImage?, titleText: String) {
        configure(icon: icon, titleText: titleText, additionalText: nil)
    }

    func configure(icon: UIImage?, titleText: String, additionalText: String?) {
        iconImageView.image = icon
        titleTextLabel.text = titleText
        if icon == nil {
            iconImageView.snp.updateConstraints { make in
                make.width.equalTo(0)
            }
            if additionalText == nil {
                titleTextLabel.snp.remakeConstraints { make in
                    make.leading.equalTo(iconImageView.snp.trailing).offset(15)
                    make.centerY.equalToSuperview()
                    make.trailing.equalTo(-8)
                }
            }
        }
    }

    func configure(titleText: String) {
        configure(icon: nil, titleText: titleText)
    }
    
    func makeResizable() {
        titleTextLabel.snp.remakeConstraints { [weak self] make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            if let accessoryView = self?.accessoryView {
                make.trailing.lessThanOrEqualTo(accessoryView.snp.leading).offset(-8)
            } else {
                make.trailing.equalToSuperview().offset(-8)
            }
        }
    }

    private func setupAccessoryView() {
        guard let accessoryView = accessoryView else { return }
        addSubview(accessoryView)

        accessoryView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-21)
        }
        makeResizable()
    }
}
