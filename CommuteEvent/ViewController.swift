//
//  ViewController.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 24-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate{
    var lManager : GeoManager = GeoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            //instanciar al usuario
            var usuario: Usuario = Usuario(Nombre: "Alberto", Password: "alt001")
            //var ubicacion = usuario.getUbicacion(locationManager, didUpdateLocations: locations)
            //println(ubicacion)

    }

    @IBAction func getCoordenadas(sender: AnyObject) {
        
        var coordinates = lManager.getCoordinates()
        println(coordinates.latitude)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

