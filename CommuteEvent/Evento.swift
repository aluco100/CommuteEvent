//
//  Evento.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 24-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import Foundation

class Evento {
    private var Nombre: String
    private var Lugar: String
    private var Fecha: NSDate
    private var Hora: String
    
    //constructor
    
    init(Nombre: String, Lugar: String, Fecha: NSDate, Hora: String){
        self.Nombre = Nombre
        self.Lugar = Lugar
        self.Fecha = Fecha
        self.Hora = Hora
    }
    
    //metodos getter
    
    internal func getNombre()->String{
        return self.Nombre
    }
    
    internal func getLugar()->String{
        return self.Lugar
    }
    
    internal func getFecha()->NSDate{
        return self.Fecha
    }
    
    internal func getHora()->String{
        return self.Hora
    }
}