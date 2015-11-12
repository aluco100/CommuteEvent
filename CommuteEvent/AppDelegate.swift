//
//  AppDelegate.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 24-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import UIKit
import CoreLocation
import SwifteriOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // inicializar alohar
        let appId: NSNumber! = 688
        let APIkey: String! = "6e579c9eb4312ba361cdb5f25f502778959fb2c0"
        let service: ACXServiceManager = ACXServiceManager.sharedManager();
       service.initializeWithAppID(appId, APIKey: APIkey, developmentModeEnabled: true, handlerQueue: nil, completion: {
            (restore:Bool, error:NSError!) -> Void in
                print("restored \(restore) ")
                print("error \(error)")
        
        if (restore == false) {
            service.createUserWithCompletion( {
                (uuid:String!, error:NSError!) -> Void in
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setValue(uuid, forKey: "Alohar_UUID")
                    self.initMonitoring(service)
            })
        } else {
            self.initMonitoring(service)
            let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            
            let components: NSDateComponents = NSDateComponents()
            components.year = 2015
            components.month = 10
            components.day =  1
            
            let referenceDate: NSDate = gregorian.dateFromComponents(components)!

            let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let uuid: String = (defaults.objectForKey("Alohar_UUID") as? String)!
            print("uID: \(uuid)")
            service.signInWithAloharUID("bf4bb541cb4ba0cbfe2a37be0a7141d028d2a5ae", completion: {
                (error: NSError!) -> Void in
                print("error: \(error)")
                
                /*service.userStayManager.fetchUserStaysFromDate(referenceDate, toDate: NSDate(timeIntervalSinceNow: 1), completion: {
                    (data : [AnyObject]!, error: NSError!) -> Void in
                    
                })*/
            })
        
        }
        
       })
        
        
        
        return true
    }
    
    func initMonitoring(service:ACXServiceManager) -> Void {
        service.startContextMonitoring();
        let notificationCenter: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        let locationManager: GeoManager = GeoManager()
        notificationCenter.addObserver(locationManager, selector: "checkIn", name: ACXLocationDidArriveAtPotentialUserStayNotification, object: nil)
        notificationCenter.addObserver(locationManager, selector: "stayUpdating", name: ACXUserStayUpdatedNotification, object: nil)
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
            print("message \(url)");
            Swifter.handleOpenURL(url);
            return true;
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

