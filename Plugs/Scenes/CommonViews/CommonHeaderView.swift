//
//  CommonHeaderView.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 16.05.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import Foundation

class CommonHeaderView: BaseView {
    
    private lazy var titleTextLabel = AppLabel {
        $0.style(textStyle: .bold36px, color: R.color.white()!)
    }
    
    override func setupView() {
        super.setupView()
        backgroundColor = R.color.darkCyan()
        
        addSubview(titleTextLabel)
        
        titleTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-30)
            make.leading.equalTo(30)
        }
    }
    
    func configureTitle(text: String) {
        titleTextLabel.text = text
    }
}
