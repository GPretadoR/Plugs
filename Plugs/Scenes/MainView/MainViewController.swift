//
//  MainViewController.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/26/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit
import MapKit
import ReactiveCocoa
import ReactiveSwift

class MainViewController: BaseViewController {

    var viewModel: MainViewViewModel?
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setupViewModel() {
        guard let viewModel = viewModel else { return }
        viewModel.mapAnnotations
            .signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] mapAnnotations in
                self?.mapView.addAnnotations(mapAnnotations)
        }
    }
    
    // MARK: - Helpers -
}
