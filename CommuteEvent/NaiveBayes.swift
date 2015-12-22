//
//  NaiveBayes.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 21-12-15.
//  Copyright © 2015 Alfredo Luco. All rights reserved.
//

import Foundation
import Parsimmon

class NaiveBayes {
    private var classifier = NaiveBayesClassifier()
    private static var instance: NaiveBayes? = nil
    
    static let lock = dispatch_queue_create("instance.lock", nil)
    
    init(){}
    
    internal static func getInstance() -> NaiveBayes{
        dispatch_sync(lock){
            if(instance == nil){
                instance = NaiveBayes()
            }
        }
        return instance!
    }
    
    internal func clasifyString(str: String) -> String{
        return self.classifier.classify(str)!
    }
    
    internal func categorizeString(str: String, category: String){
        self.classifier.trainWithText(str, category: category)
    }
}