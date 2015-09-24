//
//  ViewController.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 24-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController{
    
    var locationManager = CLLocationManager()
    var locations = [AnyObject]()
    var currentLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()
        //pedir autorizcion al usuario de ocupar localizacion
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
            currentLocation = locationManager.location
            locations.append(currentLocation)
            
            //instanciar al usuario
            var usuario: Usuario = Usuario(Nombre: "Alberto", Password: "alt001")
            var ubicacion = usuario.getUbicacion(locationManager, didUpdateLocations: locations)
            println(ubicacion)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

