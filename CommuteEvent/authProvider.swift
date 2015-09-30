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
class Provider{
    private var swifter: Swifter
    private var consumerKey: String
    private var consumerSecret: String
    private var callbackUrl: NSURL
    
    init(){
        self.consumerKey = "NYYbKwT9gwjwpeSCIGc5f6hBY"
        self.consumerSecret = "IpeZzoM2JXRzeSvOZZlSni87DRtRdQf6Wpy1Jueis5xrPIdjTJ"
        self.swifter = Swifter(consumerKey: self.consumerKey, consumerSecret: self.consumerSecret)
        self.callbackUrl = NSURL()
        self.callbackUrl.URLByAppendingPathComponent("https://api.twitter.com/1.1/")
    }
    
    //metodo de autorizacion
    
    internal func getAuth(){
        self.swifter.authorizeWithCallbackURL(self.callbackUrl, success: {
            
            (accessToken: SwifterCredential.OAuthAccessToken?, response: NSURLResponse) in
            
            //data bla bla bla
            
            println(response)
            
            }, failure: {
                (error: NSError) in
                
                //caso de error
                
                println(error)
        })
    }
    
    //metodsos getter
    
    internal func getHomeTimeline(){
        let limit: Int = 100;
        let sinceId: String = ""
        let maxId: String = ""
        //mas parametros que los vistos en el repositorio
        self.swifter.getStatusesHomeTimelineWithCount(limit, sinceID: sinceId, maxID: maxId, trimUser: true, contributorDetails: true, includeEntities: true, success: {
            (data: [JSONValue]?) in
            
            println(data)
            
            }, failure: {
                (error: NSError) in
                //en caso de error
                println(error)
        })
        
       
        
    }
        
        
}