//
//  LeftMenuHeaderView.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 26.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class LeftMenuHeaderView: BaseView {
    
    private var titleTextLabel = AppLabel {
        $0.style(textStyle: .bold15px, color: R.color.white()!)
        $0.text = R.string.common.plugAm.localized()
    }
    
    private lazy var imageView = AppImageView {
        $0.image = #imageLiteral(resourceName: "Avatar")
    }
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = R.color.grayTextColor()
        addSubview(titleTextLabel)
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.top.equalTo(12)
            make.bottom.equalTo(-12)
        }
        
        titleTextLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.centerY)
            make.leading.equalTo(imageView.snp.trailing).offset(14)
        }
        addCornerRadius(cornerRadius: 8)
    }
}
