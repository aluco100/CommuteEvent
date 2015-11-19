//
//  PlaceManager.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 12-11-15.
//  Copyright © 2015 Alfredo Luco. All rights reserved.
//

import Foundation
import QuadratTouch

class PlaceManager {
    private var userLocations: [ACXUserStay]
    private var candidatesLocations: [CandidateLocation]
    private var radar: Radar
    
    init(locations: [ACXUserStay], radarInit: Radar){
        userLocations = locations
        radar = radarInit
        candidatesLocations = []
    }
    
    //funciones getter
    
    internal func getCandidatesLocations()->[CandidateLocation]{
        return self.candidatesLocations
    }
    
    internal func catchingCandidates(){
        let locations: [ACXUserStay] = self.userLocations
        for i in locations{
            self.radar.getNearlyPlaces(i.centroidCoordinate)
            let nearly: [CandidateLocation] = radar.getVenues()
            for j in nearly{
                let nearlyLocation: CandidateLocation = j
                candidatesLocations.append(nearlyLocation)
            }
        }
    }
}