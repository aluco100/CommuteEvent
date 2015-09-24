//
//  Configuracion.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 24-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import Foundation

class Configuracion{
    
    private var rango: Int
    private var alertState: Bool
    
    //constructor
    
    init(){
        self.rango = 10
        self.alertState = false
    }
    
    //metodos getter and setter
    
    internal func getRango()->Int{
        return self.rango
    }
    
    internal func setRango(Rango: Int){
        self.rango = Rango
    }
    
    internal func getAlert()->Bool{
        return self.alertState
    }
    
    internal func setAlert(){
        if(self.alertState){
            self.alertState = false
        }else{
            self.alertState = true
        }
    }
    
}