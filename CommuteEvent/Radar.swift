//
//  Radar.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 12-11-15.
//  Copyright © 2015 Alfredo Luco. All rights reserved.
//

import Foundation
import QuadratTouch

class Radar {
    var lugares: [AnyObject]
    var twitters: [String]
    var session: Session
    init(){
        lugares = []
        twitters = []
        
        let clientID: String = "L001HQEGGIHFOKQXAWAIM20FZG4MLMXX04JC3ALESBEEVFPT"
        let clientSecret: String = "HR2TZ1AGRUXMPQEOP3N3AGUX2WAY3UQAQFKFD54YOHOSAZ2N"
        let url: String = "coevent://callback"
        let client = Client(clientID: clientID, clientSecret: clientSecret, redirectURL:url)
        let configuration = Configuration(client: client)
        Session.setupSharedSessionWithConfiguration(configuration)
        
        session = Session.sharedSession()

    }
    
    //funciones getter
    
    internal func getLugares()->[AnyObject]{
        return self.lugares
    }
    
    internal func getTwitters()->[String]{
        return self.twitters
    }
    
    internal func getNearlyPlaces(coordinates: CLLocationCoordinate2D){
        let ejes: String = "\(coordinates.latitude),\(coordinates.longitude)"
        let parameters = [Parameter.ll:ejes]
        let searchTask = self.session.venues.search(parameters) {
            (result) -> Void in
            if let response = result.response {
                print(response)
                self.lugares = (response["venues"] as! [AnyObject]?)!
            }
        }
        searchTask.start()
    
    }
}