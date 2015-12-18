//
//  PlaceManager.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 12-11-15.
//  Copyright © 2015 Alfredo Luco. All rights reserved.
//

import Foundation
import QuadratTouch
import trnql
import CoreLocation

class PlaceManager: AnyObject,TrnqlDelegate  {
    private var candidatesLocations: [CandidateLocation]
    private var radar: Radar? = Radar.getInstance()
    private var swifter: Provider? = Provider.getInstance()
    private static var instance: PlaceManager? = nil
    static let lock = dispatch_queue_create("instance.lock", nil)
    
    init(){
        candidatesLocations = []
        
        //trnql
        let api_key = "159c7ac6-9e48-4144-88b7-85feb03b55c3"
        Trnql.setAPIKey(api_key)
        SmartPlaces.start()
    }
    
    //funcion singleton
    internal static func getInstance()->PlaceManager{
        dispatch_sync(lock){
            if(instance == nil){
                instance = PlaceManager()
            }
        }
        return instance!
    }
    
    //funciones getter
    
    internal func getCandidatesLocations()->[CandidateLocation]{
        return self.candidatesLocations
    }
    
    @objc func smartPlacesChange(places: [PlaceEntry]?, error: NSError?) {
        if(places == nil){
            return
        }
        for i in places!{
            let coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: i.latitude!, longitude: i.longitude!)
            radar!.getNearlyPlaces(coordinate, callback: {() -> Void in
                let candidatos: [CandidateLocation] = (self.radar!.getVenues())
                for i in candidatos{
                    let twitter: String = i.getTwitter()
                    self.swifter!.follow(twitter)
                }
                self.saveCandidates(candidatos)
            })
        }

    }
    
    internal func saveCandidates(candidates: [CandidateLocation]?){
        var flag = true
        if(candidates == nil){
            return
        }
        let userdefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let user_data = userdefaults.objectForKey("candidates") as? NSData
        var aux = NSKeyedUnarchiver.unarchiveObjectWithData(user_data!) as! [CandidateLocation]
        for i in candidates!{
            for j in aux{
                if(i.getVenue() == j.getVenue()){
                    flag = false
                }
            }
            if(flag){
                let notification = UILocalNotification()
                notification.alertBody = "Se ha encontrado un nuevo lugar : \(i.getVenue())"
                notification.category = "invite"
                notification.fireDate = NSDate(timeIntervalSinceNow: 5)
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                aux.append(i)
            }
            flag = true
        }
        let mutable: NSMutableArray = NSMutableArray(array: aux)
        let data: NSData = NSKeyedArchiver.archivedDataWithRootObject(mutable)
        userdefaults.setObject(data, forKey: "candidates")
    }

    
}