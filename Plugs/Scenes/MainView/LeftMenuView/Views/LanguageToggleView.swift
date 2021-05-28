//
//  LanguageToggleView.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 28.05.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class LanguageToggleView: BaseView {
    
    var toggleDidChangeValue: ((Bool) -> Void)?

    private lazy var leftItemTitleLabel = AppLabel {
        $0.style(textStyle: .regular15px, color: R.color.grayTextColor()!)
    }

    private lazy var rightItemTitleLabel = AppLabel {
        $0.style(textStyle: .regular15px, color: R.color.grayTextColor()!)
    }
    
    private lazy var toggle = UISwitch {
        $0.isOn = true
        $0.addTarget(self, action: #selector(toggleChangedValue(_:)), for: .valueChanged)
    }
    
    private lazy var controllsHStackView = UIStackView {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 8
    }
    
    override func setupView() {
        super.setupView()
        
        addSubview(controllsHStackView)
        
        controllsHStackView.addArrangedSubview(leftItemTitleLabel)
        controllsHStackView.addArrangedSubview(toggle)
        controllsHStackView.addArrangedSubview(rightItemTitleLabel)
                
        controllsHStackView.snp.makeConstraints { make in
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
        }
    }
    
    func configure(leftTitle: String = "", rightTitle: String = "") {
        leftItemTitleLabel.text = leftTitle
        rightItemTitleLabel.text = rightTitle
    }
    
    func setToggleState(isOn: Bool) {
        toggle.isOn = isOn
    }
    
    @objc func toggleChangedValue(_ sender: Any) {
        if let newValue = (sender as? UISwitch)?.isOn {
            toggleDidChangeValue?(newValue)
        }        
    }
}
