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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //instanciar al usuario
        var usuario: Usuario = Usuario(Nombre: "Alberto", Password: "alt001")
        let ubicacion: CLLocationCoordinate2D = usuario.getUbicacion()
        var provider: Provider = Provider()
        provider.getAuth()

    }

    @IBAction func getCoordenadas(sender: AnyObject) {
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

