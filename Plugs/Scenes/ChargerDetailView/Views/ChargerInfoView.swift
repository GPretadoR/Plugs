//
//  ChargerInfoView.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 02.05.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class ChargerInfoView: BaseView {

    private lazy var chargerNameLabel = AppLabel {
        $0.style(textStyle: .semiBold22px, color: R.color.white()!)
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    
    private lazy var chargerTypesLabel = AppLabel {
        $0.style(textStyle: .regular15px, color: R.color.white()!)
    }
    
    private lazy var availabilityHoursLabel = AppLabel {
        $0.style(textStyle: .regular14px, color: R.color.white()!)
        $0.text = "24/7"
    }
    
    private lazy var timeIconImageView = AppImageView {
        $0.image = #imageLiteral(resourceName: "clock")
    }
    
    override func setupView() {
        super.setupView()
        backgroundColor = R.color.darkCyan()
        
        addSubview(chargerNameLabel)
        addSubview(chargerTypesLabel)
        addSubview(availabilityHoursLabel)
        addSubview(timeIconImageView)
        
        chargerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(27)
            make.trailing.equalTo(timeIconImageView.snp.leading).offset(-20)
        }
        
        chargerTypesLabel.snp.makeConstraints { make in
            make.leading.equalTo(chargerNameLabel)
            make.top.equalTo(chargerNameLabel.snp.bottom).offset(6)
            make.bottom.equalTo(-14)
        }
        
        availabilityHoursLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.centerY.equalTo(chargerNameLabel)
        }
        
        timeIconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(availabilityHoursLabel)
            make.trailing.equalTo(availabilityHoursLabel.snp.leading).offset(-7)
        }
    }
    
    func configure(chargerInfo: ChargerInfoViewModel) {
        chargerNameLabel.text = chargerInfo.chargerName
        chargerTypesLabel.text = chargerInfo.chargerTypes
        availabilityHoursLabel.text = chargerInfo.availabilityHours
    }
}

struct ChargerInfoViewModel {
    var chargerName: String
    var chargerTypes: String
    var availabilityHours: String
}
