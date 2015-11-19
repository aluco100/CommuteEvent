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
    var candidatos: [CandidateLocation]
    var session: Session
    init(){
        candidatos = []
        
        let clientID: String = "L001HQEGGIHFOKQXAWAIM20FZG4MLMXX04JC3ALESBEEVFPT"
        let clientSecret: String = "HR2TZ1AGRUXMPQEOP3N3AGUX2WAY3UQAQFKFD54YOHOSAZ2N"
        let url: String = "coevent://callback"
        let client = Client(clientID: clientID, clientSecret: clientSecret, redirectURL:url)
        let configuration = Configuration(client: client)
        Session.setupSharedSessionWithConfiguration(configuration)
        
        session = Session.sharedSession()

    }
    
    //funciones getter
    
    internal func getVenues()->[CandidateLocation]{
        return self.candidatos
    }
    
    internal func getNearlyPlaces(coordinates: CLLocationCoordinate2D, callback: ()->Void){
        let ejes: String = "\(coordinates.latitude),\(coordinates.longitude)"
        let parameters = [Parameter.ll:ejes]
        let searchTask = self.session.venues.search(parameters) {
            (result) -> Void in
            if let response = result.response {
                print(response["venues"]?["categories"])
                if(response["venues"]?["contact"] != nil){
                    let name: String = (response["venues"]!["name"] as? String)!
                    let twitter: String = (response["venues"]!["contact"]!!["twitter"] as? String)!
                    let lat: CLLocationDegrees = (response["venues"]!["location"]!!["lat"] as? CLLocationDegrees)!
                    let long: CLLocationDegrees = (response["venues"]!["location"]!!["lng"] as? CLLocationDegrees)!
                    let coordenada: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    let venue: CandidateLocation = CandidateLocation(Venue: name, Twitter: twitter, Coordinates: coordenada)
                    self.candidatos.append(venue)
                }
            }
            callback()
        }
        searchTask.start()
    
    }
}