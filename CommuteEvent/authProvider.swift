//
//  authProvider.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 26-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//
//
//


/*
###################Preguntas###############
-Que se pone en el callback url de la api de twitter



*/

import Foundation
import SwifteriOS
import SafariServices
import UIKit

class Provider{
    private var swifter: Swifter
    private var consumerKey: String
    private var consumerSecret: String
    private var callbackUrl: NSURL
    private var tweets: [JSONValue]
    
    init(){
        self.consumerKey = "NYYbKwT9gwjwpeSCIGc5f6hBY"
        self.consumerSecret = "IpeZzoM2JXRzeSvOZZlSni87DRtRdQf6Wpy1Jueis5xrPIdjTJ"
        self.swifter = Swifter(consumerKey: self.consumerKey, consumerSecret: self.consumerSecret)
        self.callbackUrl = NSURL(string: "coevent://callback")!
        self.tweets = []
    }
    
    //metodo de autorizacion
    
    internal func getAuth(){
        
        swifter.authorizeWithCallbackURL(self.callbackUrl,
            success: { (accessToken, response) -> Void in
                self.getHomeTimeline()
            },
            failure: { (error) -> Void in
                println(error);
            }
        )
    }

    
    //metodsos getter
    
    internal func getHomeTimeline(){
        let limit: Int = 100;
        //mas parametros que los vistos en el repositorio
        self.swifter.getStatusesHomeTimelineWithCount(limit, trimUser: true, contributorDetails: true, includeEntities: true, success: {
            (data: [JSONValue]?) in
            self.tweets = data!
            println(data)
            
            }, failure: {
                (error: NSError) in
                //en caso de error
                println(error)
        })
        
    }
    
    internal func getTweets() -> [JSONValue]{
        return self.tweets
    }
        
        
}