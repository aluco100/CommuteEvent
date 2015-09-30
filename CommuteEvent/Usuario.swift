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
    private var location: GeoManager
    
    //constructor
    
     init(Nombre: String, Password: String){
        self.Nombre = Nombre
        self.Password = Password
        self.location = GeoManager()
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
    
    internal func getUbicacion() ->CLLocationCoordinate2D{
        return location.getCoordinates()
    }

}