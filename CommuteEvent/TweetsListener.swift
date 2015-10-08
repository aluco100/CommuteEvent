//
//  TweetsListener.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 08-10-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import Foundation
import SwifteriOS

protocol TweetsListener{
    func onTweetsReload(tweets: [JSONValue]) -> Void
}