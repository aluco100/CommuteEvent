//
//  Usuario.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 24-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import Foundation
import MapKit

class Usuario{
    private var Nombre: String
    private var Password: String
    
    //constructor
    
     init(Nombre: String, Password: String){
        self.Nombre = Nombre
        self.Password = Password
    }
    
    //funciones getter and setter
    internal func getNombre() ->String{
        return self.Nombre
    }
    
    internal func setNombre(Nombre: String){
        self.Nombre = Nombre;
    }
    
    internal func getPassword()->String{
        return self.Password
    }
    
    internal func setPassword(Password: String){
        self.Password = Password
    }
    
    internal func getUbicacion(Manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) ->CLLocationCoordinate2D{
        let lastLocation = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
        
        return center
    }

}