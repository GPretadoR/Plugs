//
//  CargerDetailsViewController.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import UIKit

class ChargerDetailsViewController: BaseViewController {

    var titleTextLabel = AppLabel {
        $0.style(textStyle: .bold14px, color: R.color.black()!)
        $0.text = "Ganio == "
    }
    
    var viewModel: ChargerDetailsViewViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoadTriggered()
    }
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(titleTextLabel)
        
        titleTextLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func setupViewModel() {
        super.setupViewModel()
        guard let viewModel = viewModel else { return }
        
        viewModel.charger
            .signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] charger in
                self?.titleTextLabel.text = charger?.name
            }
    }
}
