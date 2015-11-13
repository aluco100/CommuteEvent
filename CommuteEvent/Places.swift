//
//  Places.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 10-11-15.
//  Copyright © 2015 Alfredo Luco. All rights reserved.
//

import Foundation


struct Place {
    
}

class Places {
    private var stays: [ACXUserStay]
    private var places: [ACXPlace]
    
    init(){
        stays = []
        places = []
    }
    
    
    internal func getPlaces()->[ACXUserStay]{
        
        var places:[ACXUserStay] = []
        let mainService: ACXServiceManager = ACXServiceManager.sharedManager();
        let service: ACXUserStayManager = mainService.userStayManager;
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let components: NSDateComponents = NSDateComponents()
        components.year = 2015
        components.month = 10
        components.day =  1
        
        let referenceDate: NSDate = gregorian.dateFromComponents(components)!
        service.fetchUserStaysFromDate(referenceDate, toDate: NSDate(timeIntervalSinceNow: 1), completion: {
            (data : [AnyObject]!, error: NSError?) -> Void in
            places = (data as? [ACXUserStay])!
            //print(places)
            //print(error)
            for i in places{
                print("coordinate \(i.centroidCoordinate)")
            }
            self.stays = places
        })
        
        return self.stays

    }
    
    internal func getInternalCandidateList()->[AnyObject]{
        var places: [ACXPlace] = []
        let mainService: ACXServiceManager = ACXServiceManager.sharedManager()
        let service: ACXUserStayManager = mainService.userStayManager
        let userStay: ACXUserStay = self.stays.last!
        print(userStay)
        service.fetchFullCandidatePlaceListForUserStay(userStay, completion: {
            (data: [AnyObject]?, error: NSError?)-> Void in
            places = (data as? [ACXPlace])!
            self.places = places
            print(data)
            print(error)
        })
        return places
    }
    
}