//
//  LocationManager.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 25-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: CLLocationManager, CLLocationManagerDelegate{
    private var locationManager : CLLocationManager = CLLocationManager()
    
    //constructor
    override init() {
        self.locationManager.requestAlwaysAuthorization()
        
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        }
        
    }
}