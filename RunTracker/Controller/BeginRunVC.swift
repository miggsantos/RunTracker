//
//  BeginRunVC.swift
//  RunTracker
//
//  Created by Miguel Santos on 12/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class BeginRunVC: LocationVC {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lastRunCloseButton: UIButton!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var lastRunBGView: UIView!
    @IBOutlet weak var lastRunStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkLocationAuthStatus()

    }

    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        mapView.delegate = self
        manager?.startUpdatingLocation()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMapView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func showOrHideLastRunPanel(show: Bool) {
        lastRunStack.isHidden = show
        lastRunBGView.isHidden = show
        lastRunCloseButton.isHidden = show
    }
    
    func setupMapView() {
        if let overlay = addLastRunToMap() {
            if(mapView.overlays.count > 0){
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.add(overlay)
            showOrHideLastRunPanel(show: false)
  
        } else {
            showOrHideLastRunPanel(show: true)
            centerMapOnUserLocation()
        }
    }
    
    func addLastRunToMap() -> MKPolyline? {
        guard let lastRun = Run.getAllRuns()?.first else {
            return nil
        }
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToKm(places: 3)) km"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
        
        var coordinate = [CLLocationCoordinate2D]()
        for location in lastRun.locations {
            coordinate.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longintude))
        }
        
        mapView.userTrackingMode = .none
        mapView.setRegion(centerMapOnPrevRoute(locations: lastRun.locations), animated: true)
        
        return MKPolyline(coordinates: coordinate, count: lastRun.locations.count)
    }

    func centerMapOnUserLocation(){
        mapView.userTrackingMode = .follow
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func centerMapOnPrevRoute(locations: List<Location>) -> MKCoordinateRegion {
        guard let initialLocation = locations.first else {
            return MKCoordinateRegion()
        }
        var minLat = initialLocation.latitude
        var minLng = initialLocation.longintude
        var maxLat = minLat
        var maxLng = minLng
        
        for location in locations {
            minLat = min(minLat, location.latitude)
            minLng = min(minLng, location.longintude)
            maxLat = max(maxLat, location.latitude)
            maxLng = max(maxLng, location.longintude)
        }

        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2  , longitude: (minLng + maxLng) / 2),
                                  span: MKCoordinateSpanMake((maxLat - minLat) * 1.4, (maxLng - minLng) * 1.4))
    }
    
    @IBAction func lastRunCloseButtonPressed(_ sender: Any) {
        showOrHideLastRunPanel(show: true)
        centerMapOnUserLocation()
    }
    
    @IBAction func locationCenterButtonPressed(_ sender: Any) {
        
        centerMapOnUserLocation()
    }
    

    
}

extension BeginRunVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        renderer.lineWidth = 4
        return renderer
    }
    
}

