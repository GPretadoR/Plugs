//
//  MapView.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 12.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//
//

import GoogleMaps
import ReactiveCocoa
import ReactiveSwift
import UIKit

class MapView: BaseView {
    private var mapView: GMSMapView?

    private let defaultZoomLevel: Float = 17.0

    var viewModel = MapViewViewModel()
    weak var delegate: MapViewDelegate?

    func configure() {
        addMapView()
        setupViewModel()
    }

    func currentZoomLevel() -> Float {
        return mapView?.camera.zoom ?? defaultZoomLevel
    }

    func moveCamera(toLocation: CLLocationCoordinate2D, zoomLevel: Float) {
        let camera = GMSCameraPosition.camera(withLatitude: toLocation.latitude, longitude: toLocation.longitude, zoom: zoomLevel)
        mapView?.animate(to: camera)
    }

    // MARK: - Private funcs

    private func setupViewModel() {
        
    }

    private func addMapView() {
        mapView = GMSMapView(frame: frame)
        mapView?.animate(toZoom: defaultZoomLevel)
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
        mapView?.delegate = self
        viewModel.markers.signal
            .observeValues { [weak self] markers in
            markers.forEach { $0.map = self?.mapView }
        }

        if let mapView = mapView {
            addSubview(mapView)
            sendSubviewToBack(mapView)
        }
    }
    
    func addPolyLine(encodedString: String) {
        let path = GMSMutablePath(fromEncodedPath: encodedString)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5
        polyline.strokeColor = .blue
        polyline.map = mapView

    }
}

extension MapView: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let chargerMarker = marker as? ChargerMarker else { return }
        delegate?.didTapAtInfoWindow(of: chargerMarker)
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        return nil
    }
}
