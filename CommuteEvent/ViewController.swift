//
//  ViewController.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 24-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//


import UIKit
import MapKit
import SwifteriOS
import QuadratTouch
import trnql

class ViewController: UIViewController,CLLocationManagerDelegate,UITableViewDataSource, UITableViewDelegate,TrnqlDelegate,TweetsListener{
    
    //outlets
    
    @IBOutlet weak var Alert: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //variables
    var provider: Provider = Provider.getInstance()
    var tweets:[JSONValue] = []
    var hashtags:[String] = []
    var users:[String] = []
    var radar: Radar = Radar.getInstance()
    var placemngr: PlaceManager = PlaceManager.getInstance()
    var places: [CandidateLocation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //autorizar Twitter
        provider.getAuth({
            (error: NSError?) -> Void in
            if(error == nil){
                self.provider.registerTweetsListener(self)
                self.placemngr = PlaceManager.getInstance()
                self.provider.getHomeTimeline({
                    (tweets: [JSONValue], error: NSError?) -> Void in
                    
                })
            }else {
                print("error viewDidLoad: \(error)")
            }
        })
        
        view.backgroundColor = UIColor.init(patternImage: UIImage(named: "background.jpg")!)
        
        //instanciar la tabla
        tableView.dataSource = self
        tableView.delegate = self
        
        placemngr = PlaceManager.getInstance()
        let userdefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if(userdefaults.objectForKey("candidates") != nil){
            let user_data = userdefaults.objectForKey("candidates") as? NSData
            let aux = NSKeyedUnarchiver.unarchiveObjectWithData(user_data!) as! [CandidateLocation]
            for i in aux{
                print("candidate twitter: \(i.getTwitter())")
                places.append(i)
            }
        }
        isTheresPlaces()
    }
    
    func onTweetsReload(tweets: [JSONValue]) -> Void{
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tweets = provider.getTweets()
        hashtags = provider.getHashtags()
        users = provider.getUsers()
        //return hashtags.count
        //return tweets.count
        isTheresPlaces()
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        
        //cell.textLabel?.text = hashtags[indexPath.row]
        //cell.textLabel?.text = tweets[indexPath.row]["text"].string
        //cell.textLabel?.text = users[indexPath.row]
        cell.textLabel?.text = places[indexPath.row].getVenue()
        return cell
    }
    
    func isTheresPlaces()->Void{
        if(self.places.count == 0){
            Alert.hidden = false
            Alert.text = "There's no places yet"
        }else{
            Alert.hidden = true
        }
    }
    

}

