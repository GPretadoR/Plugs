//
//  MainViewController.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/26/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import UIKit

class MainViewController: BaseViewController {

    var viewModel: MainViewViewModel?
    
    var mapView = MapView()
    
    private lazy var leftMenuButton = AppButton {
        $0.backgroundColor = .clear
        $0.backgroundImage = #imageLiteral(resourceName: "leftMenuIcon")
        $0.layer.cornerRadius = 0
        $0.addTarget(self, action: #selector(showMenuButtonTapped(_:)), for: .touchUpInside)
    }
    
    private lazy var topLogoImageView = AppImageView {
        $0.image = #imageLiteral(resourceName: "PlugLogo")
    }
    
    private lazy var footerLogoImageView = AppImageView {
        $0.image = #imageLiteral(resourceName: "Partners")
        $0.contentMode = .scaleAspectFit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        
        mapView = MapView(frame: view.frame)
        mapView.configure()
        mapView.delegate = self

        view.addSubview(mapView)
        view.sendSubviewToBack(mapView)
        view.addSubview(leftMenuButton)
        view.addSubview(topLogoImageView)
        view.addSubview(footerLogoImageView)
        
        leftMenuButton.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.leading.equalTo(view.snp.leading).inset(16)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
        }
        
        topLogoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(leftMenuButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        footerLogoImageView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safe.bottom).offset(-25)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
    }
    
    override func setupViewModel() {
        super.setupViewModel()
        guard let viewModel = viewModel else { return }
        
        viewModel.markers
            .signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] markers in
                self?.mapView.viewModel.configure(with: markers)
            }
        
        viewModel.moveCameraToLocation
            .signal
            .observe(on: UIScheduler())
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] (location, zoomLevel) in
                self?.mapView.moveCamera(toLocation: location, zoomLevel: zoomLevel)
                viewModel.initialCameraMove = false //Very bad workaround
            }
    }
    
    override func shouldHideNavigationBar() -> Bool {
        true
    }
    
    // MARK: - Actions

    @objc func showMenuButtonTapped(_ sender: Any) {
        viewModel?.showLeftMenuButtonTapped()
    }
    
    // MARK: - Helpers -
}

extension MainViewController: MapViewDelegate {
    func didTapAtInfoWindow(of marker: ChargerMarker) {
        viewModel?.didTapInfoWindow(of: marker)
    }
}
