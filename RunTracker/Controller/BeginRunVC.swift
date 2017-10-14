//
//  BeginRunVC.swift
//  RunTracker
//
//  Created by Miguel Santos on 12/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit
import MapKit

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
        mapView.delegate = self

        
    }

    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
        getLastRun()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func getLastRun(){
        guard let lastRun = Run.getAllRuns()?.first else {
            lastRunStack.isHidden = true
            lastRunBGView.isHidden = true
            lastRunCloseButton.isHidden = true
            return
        }
        lastRunStack.isHidden = false
        lastRunBGView.isHidden = false
        lastRunCloseButton.isHidden = false
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToKm(places: 3)) km"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
    }
    
    
    @IBAction func lastRunCloseButtonPressed(_ sender: Any) {
        lastRunStack.isHidden = true
        lastRunBGView.isHidden = true
        lastRunCloseButton.isHidden = true
    }
    
    @IBAction func locationCenterButtonPressed(_ sender: Any) {
        
        
    }
    

    
}

extension BeginRunVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            
            checkLocationAuthStatus()
            
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            
            
        }
    }
    
}

