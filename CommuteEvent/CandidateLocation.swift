//
//  CandidateLocation.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 13-11-15.
//  Copyright © 2015 Alfredo Luco. All rights reserved.
//

import Foundation

class CandidateLocation {
    private var venue: String
    private var twitter: String
    private var coordinates: CLLocationCoordinate2D
    
    
    init(Venue: String, Twitter: String, Coordinates: CLLocationCoordinate2D){
        self.venue = Venue
        self.twitter = Twitter
        self.coordinates = Coordinates
    }
    
    internal func getVenue()->String{
        return self.venue
    }
    
    internal func getTwitter()->String{
        return self.twitter
    }
    
    internal func getCoordinates()->CLLocationCoordinate2D{
        return self.coordinates
    }
}