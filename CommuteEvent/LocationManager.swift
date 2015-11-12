//
//  LocationManager.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 25-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import Foundation
import MapKit

class GeoManager: CLLocationManager, CLLocationManagerDelegate{
    private var coordinates : CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    private var lManager = CLLocationManager()
    
    //constructor
    override init() {
        super.init()
        self.lManager.requestAlwaysAuthorization()
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            lManager.delegate = self
            lManager.desiredAccuracy = kCLLocationAccuracyBest
            lManager.startUpdatingLocation()
        }
        

    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = (locations.last! as CLLocation)
        self.coordinates = location.coordinate
    }
    
    internal func getCoordinates()->CLLocationCoordinate2D{
        return self.coordinates
    }
    
    
    internal func checkIn(notification: NSNotification){
        let location = notification.userInfo![ACXLocationLocationKey] as? CLLocation
        print(location)
    }
}