//
//  authProvider.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 26-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import Foundation
import SwifteriOS
class Provider{
    private var swifter: Swifter
    private var consumerKey: String
    private var consumerSecret: String
    
    init(Key: String, Secret: String){
        self.consumerKey = Key
        self.consumerSecret = Secret
        self.swifter = Swifter(consumerKey: self.consumerKey, consumerSecret: self.consumerSecret)
    }
    
    //metodo de autorizacion
    
    internal func getAuth(callbackUrl: NSURL){
        self.swifter.authorizeWithCallbackURL(callbackUrl, success: {
            
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
    
        //porque mierda get hometimeline tiene mas argumentos?
       
        
    }
        
        
}