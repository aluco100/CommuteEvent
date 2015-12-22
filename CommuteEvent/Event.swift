//
//  Evento.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 24-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import Foundation
import CoreLocation

class Event:NSObject, NSCoding {
    private var Name: String
    private var Coordinates: CLLocationCoordinate2D
    private var Date: String
    private var Twitter: String
    
    //constructor
    
    init(_name: String, _latitude: CLLocationDegrees, _longitude: CLLocationDegrees, _date: String, _twitter: String){
        self.Name = _name
        let coordinate = CLLocationCoordinate2D(latitude: _latitude, longitude: _longitude)
        self.Coordinates = coordinate
        self.Date = _date
        self.Twitter = _twitter
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey("event_name") as! String
        let lat = aDecoder.decodeObjectForKey("event_latitude") as! CLLocationDegrees
        let long = aDecoder.decodeObjectForKey("event_longitude") as! CLLocationDegrees
        let date = aDecoder.decodeObjectForKey("event_date") as! String
        let twitter = aDecoder.decodeObjectForKey("event_twitter") as! String
        self.init(_name: name, _latitude: lat, _longitude: long, _date: date, _twitter: twitter)
    }
    
    //metodos getter
    internal  func getName() -> String{
        return self.Name
    }
    
    internal func getCoordinates() -> CLLocationCoordinate2D{
        return self.Coordinates
    }
    
    internal func getDate() -> String {
        return self.Date
    }
    
    internal func getTwitter() -> String{
        return self.Twitter
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.Name, forKey: "event_name")
        aCoder.encodeObject(self.Coordinates.latitude, forKey: "event_latitude")
        aCoder.encodeObject(self.Coordinates.longitude, forKey: "event_longitude")
        aCoder.encodeObject(self.Date, forKey: "event_date")
        aCoder.encodeObject(self.Twitter, forKey: "event_twitter")
    }
}