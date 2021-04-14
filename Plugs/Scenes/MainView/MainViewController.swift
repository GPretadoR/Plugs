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
        $0.backgroundImage = #imageLiteral(resourceName: "ic_navbar_menu")
        $0.layer.cornerRadius = 0
        $0.addTarget(self, action: #selector(showMenuButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setupView() {
        super.setupView()
        
        mapView = MapView(frame: view.frame)
        mapView.configure()
//        mapView.delegate = self

        view.addSubview(mapView)
        view.sendSubviewToBack(mapView)
        view.addSubview(leftMenuButton)
        
        leftMenuButton.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.leading.equalTo(view.snp.leading).inset(8)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
        }
    }
    
    override func setupViewModel() {
        guard let viewModel = viewModel else { return }
        viewModel.mapAnnotations
            .signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] mapAnnotations in
//                self?.mapView.addAnnotations(mapAnnotations)
        }
        
        viewModel.moveCameraToLocation.output
            .observe(on: UIScheduler())
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] (location, zoomLevel) in
                self?.mapView.moveCamera(toLocation: location, zoomLevel: zoomLevel)
            }
        
        viewModel.drawDirection
            .output
            .observe(on: UIScheduler())
            .observeResult { [weak self] result in
                switch result {
                case .success(let polyline): break
                
                case .failure(let error):
                    print("direction found error", error)
                }
            }
            
    }
    
    // MARK: - Actions

    @objc func showMenuButtonTapped(_ sender: Any) {
        viewModel?.showLeftMenuButtonTapped()
    }
    
    // MARK: - Helpers -
}
