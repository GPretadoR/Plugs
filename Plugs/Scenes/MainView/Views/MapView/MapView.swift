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
//    private var clusterManager: GMUClusterManager?
//
//    private var renderer: GMUGeometryRenderer?
//    private var kmlParser: GMUKMLParser?

    private var isExpandable = false

    private let defaultZoomLevel: Float = 17.0

    var viewModel = MapViewViewModel()
//    weak var delegate: MapViewDelegate?

    func configure() {
        addMapView()

        viewModel.configure()

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
    // swiftlint:disable line_length
    private func addMapView() {
        mapView = GMSMapView(frame: frame) // GMSMapView.map(withFrame: self.frame, camera: camera)        
        mapView?.animate(toZoom: defaultZoomLevel)
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true

        viewModel.markers.signal.observeValues { [weak self] markers in
            markers.forEach { $0.map = self?.mapView }
        }
        
        addPolyLine(encodedString: "ixetFketnGrQoMjCxEzC`J@s@gIyUoBoKeBgTgGaOsGqGuIyEyOoEiH{@iBqDwN_H}G|BwUgTcGkHiDaMeKiOsBeI~Bqh@{B_LaN{UsVoZya@g`@id@aQ_NI}Cd@yC`@_D^w[vFaZtO_TzAgPuCo\\e^}d@}nAsRkf@oJqPoZsVsd@yp@oO}G_I_A{_@Zw[eCw\\oKyqAix@ceAip@up@ua@sc@{]mq@wk@aPmEaObAgm@lP_x@rMyc@dG_KrBuGkA}DeFaBkJqCuJuFkDsJe@eF_DmCmKoAuQcEeFcMyCuHqDsKgX_H_JgN\\mMY{f@gZoWaQuWuXcd@wf@uqAqyAmp@saAcg@yt@iY}TcpAmn@ar@{`@afAov@sPiNiJwQue@sfAka@{v@uzAwnCkv@{oA_z@aaB{m@a_BsMw^oQqy@{`@mjBiRajAaJ_c@kZgaAuM}c@gHam@L_u@dUq_DdMueBMkQcTwdBwFcPca@ml@{lA}eB}_@}ZuXaY{HqC_]vEo\\|RiZ~}@sLfm@_Ot^{LzOmNdL}QdDyIlFuKbM}MhZkOzMwqAnXk`@vNyR|]cw@voAyMh^wQbY}NjUiJrXwPvOgEdEiBpHiCz\\uK|YkFp_@cCpRmBt@i}Apj@e]`M{MbJ_T|^cHjN{C|BqCWY|ADnJqGhDkLtO_N~AIhHeBtCmHLvLhCMl@yGcAgDpAn@bIgAbDqPjFnBh@lS}EiAbAkUzHqHtKsFtFaE}@qFxLwKa@oFwBxInGjKbAxOqHx@HwGnPwRVgMiAgKlAqZ|DsL]oZ}Jo^BoJjAeDeD_BqWeCiOeCsVkDqL{GyHoD_AmKxAeR|CaTbGuJRkDdBuCiByD_He@AiH{FcFgEyFHoJAuEmC}QoOw^uv@oL_m@mEk`@c@{WwFsm@mAaRgJub@sSo]mYqSuOgG{C{@aMVsGwSg@wTkDwHx@gQ`FmO~@uO`EwUzKwf@jB{JeDgZn@yNqBc[aCmg@yCg]n@qd@bDuXxCsPjUib@lDkW_Cec@bDiOoEyo@lAyGdEcJpGePk@uGaHkMuGYkVsJgGHyD_AsF_H`ByDhD}PhBa\\uDg[wImXqIyPqDeVqGcJoImFeDqKqHyHwEyBoJM_J_CqQwJsEcNqHsa@yGcK}YiAmFkCkDwGuN_`@eCuGeIyGkSeTgBqYOgWcGkP{M_UqMwe@iDaPwDeDyMqKcJ}Lg[oIcYr@uMwKk_@{@wVmHcNqBeL{CiLlBaI^qHkFwFgFiDKeMfDoEcA}CeGd@_UiIuJsEwSeNuV")
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

//    private func isExpandableCluster(clusterManager: GMUClusterManager, cluster: GMUCluster) -> Bool {
//        var isExpandable = true
//        let clusters = clusterManager.algorithm.clusters(atZoom: mapView?.maxZoom ?? defaultZoomLevel)
//
//        for clusterItem in clusters where clusterItem.count == cluster.count {
//            if (clusterItem.items.first?.isEqual(cluster.items.first))! {
//                isExpandable = false
//                break
//            }
//        }
//        return isExpandable
//    }
//}
//
//extension MapView: GMUClusterManagerDelegate, GMSMapViewDelegate {
//    // MARK: - GMUClusterManagerDelegate
//
//    func clusterManager(_ clusterManager: GMUClusterManager, didTap clusterItem: GMUClusterItem) -> Bool {
//        moveCamera(toLocation: clusterItem.position, zoomLevel: mapView?.camera.zoom ?? defaultZoomLevel)
//        delegate?.didTapClusterItem(clusterItem: clusterItem)
//        return false
//    }
//
//    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
//        var zoomLevel = mapView?.camera.zoom ?? defaultZoomLevel
//        isExpandable = isExpandableCluster(clusterManager: clusterManager, cluster: cluster)
//        if isExpandable {
//            zoomLevel += 1
//        }
//        moveCamera(toLocation: cluster.position, zoomLevel: zoomLevel)
//        return false
//    }
//
//    // MARK: - GMUMapViewDelegate
//
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        delegate?.didTapAtCoordinate(coordinate: coordinate)
//    }
//}
