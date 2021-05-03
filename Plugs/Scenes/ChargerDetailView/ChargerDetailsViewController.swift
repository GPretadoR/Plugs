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
    
    private lazy var chargerImageView = AppImageView {
        $0.backgroundColor = .clear
    }
    
    private lazy var chargerInfoView = ChargerInfoView()
    
    private lazy var addressLabel = AppLabel {
        $0.style(textStyle: .regular13px, color: R.color.black()!)
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    
    private lazy var markerIconImageView = AppImageView {
        $0.image = #imageLiteral(resourceName: "chargingStationIcon")
    }
    
    private lazy var separatorView = SeparatorView {
        $0.orientation = .horizontal
    }
    
    private lazy var getDiretionButton = AppButton {
        $0.setup(with: .filled)
        $0.style(for: .bold13px, color: R.color.white()!)
        $0.backgroundColor = R.color.appGreen()
        $0.titleText = R.string.localizable.chargerDetailGetDirectionButtonText.localized()
        $0.addTarget(self, action: #selector(getDirectionButtonTapped(_:)), for: .touchUpInside)
    }
    
    var viewModel: ChargerDetailsViewViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoadTriggered()
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(chargerImageView)
        view.addSubview(chargerInfoView)
        view.addSubview(markerIconImageView)
        view.addSubview(addressLabel)
        view.addSubview(getDiretionButton)
        view.addSubview(separatorView)
        
        chargerImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safe.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(209)
        }
        
        chargerInfoView.snp.makeConstraints { make in
            make.top.equalTo(chargerImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        markerIconImageView.snp.makeConstraints { make in
            make.leading.equalTo(25)
            make.top.equalTo(chargerInfoView.snp.bottom).offset(28)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.centerY.equalTo(markerIconImageView)
            make.leading.equalTo(markerIconImageView.snp.trailing).offset(8)
            make.trailing.equalTo(getDiretionButton.snp.leading).offset(-20)
        }
        
        getDiretionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(markerIconImageView)
            make.height.equalTo(31)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(28)
            make.leading.equalTo(markerIconImageView)
            make.trailing.equalTo(getDiretionButton.snp.trailing)
        }
    }
    
    override func setupViewModel() {
        super.setupViewModel()
        guard let viewModel = viewModel else { return }
        
        viewModel.charger
            .signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] charger in
                if let charger = charger {
                    self?.updateView(charger: charger)
                }
            }
    }
    
    // MARK: - Action
    
    @objc func getDirectionButtonTapped(_ sender: Any) {
        viewModel?.didTapGetDirectionButton()
    }
    
    // MARK: - Private funcs
    
    private func updateView(charger: ChargerStationObject) {
        let chargerInfo = ChargerInfoViewModel(chargerName: charger.name ?? "", chargerTypes: charger.plugType ?? "", availabilityHours: "24/7")
        chargerInfoView.configure(chargerInfo: chargerInfo)
        DispatchQueue.main.async {
            self.chargerImageView.image = self.viewModel?.getChargerImage(urlString: charger.photoURL ?? "")
        }
        addressLabel.text = charger.city
    }
}
