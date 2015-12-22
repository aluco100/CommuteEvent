//
//  ViewController.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 24-09-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

/*
Falta por hacer:

1.- obtener los tweets por text mining atribuyendoles un peso
2.- verificar si efectivamente se localizan los lugares con trnql


*/


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
    var events: [Event] = []
    var Naive = NaiveBayes.getInstance()
    
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
                    //capturar eventos segun tweets
                    for i in tweets{
                        print(i)
                        let textproc = TextProcessor(text: i["text"].string!)
                        textproc.tokenizerFromText()
                        if(textproc.isEvent){
                            let place = self.provider.getCandidateFromTweetUser(i["user"]["screen_name"].string?.lowercaseString)
                            let event = Event(_name: i["text"].string!, _latitude: (place?.getCoordinates().latitude)!, _longitude: (place?.getCoordinates().longitude)!, _date: i["user"]["created_at"].string!, _twitter: (i["user"]["screen_name"].string?.lowercaseString)!)
                            self.events.append(event)
                        }else{
                            let type = self.Naive.clasifyString(i["text"].string!)
                            if(type == "event"){
                                let place = self.provider.getCandidateFromTweetUser(i["user"]["screen_name"].string?.lowercaseString)
                                let event = Event(_name: i["text"].string!, _latitude: (place?.getCoordinates().latitude)!, _longitude: (place?.getCoordinates().longitude)!, _date: i["user"]["created_at"].string!, _twitter: (i["user"]["screen_name"].string?.lowercaseString)!)
                                self.events.append(event)
                            }
                        }
                    }
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
        if(userdefaults.objectForKey("events") != nil){
            let user_data = userdefaults.objectForKey("events") as? NSData
            let aux = NSKeyedUnarchiver.unarchiveObjectWithData(user_data!) as! [Event]
            for i in aux{
                events.append(i)
            }
        }
        isTheresEvents()
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
        isTheresEvents()
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        
        //cell.textLabel?.text = hashtags[indexPath.row]
        //cell.textLabel?.text = tweets[indexPath.row]["text"].string
        //cell.textLabel?.text = users[indexPath.row]
        cell.textLabel?.text = events[indexPath.row].getName()
        return cell
    }
    
    func isTheresEvents()->Void{
        if(self.events.count == 0){
            Alert.hidden = false
            Alert.text = "There's no events yet"
        }else{
            Alert.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "eventSegue"){
            let indexPath = self.tableView.indexPathForSelectedRow
            let selectedEvent = events[(indexPath?.row)!]
            let place: CandidateLocation? = self.provider.getCandidateFromTweetUser(selectedEvent.getTwitter().lowercaseString)
            let destination = segue.destinationViewController as? MapViewController
            if(place != nil){
                let point : MKPointAnnotation = MKPointAnnotation()
                point.coordinate = CLLocationCoordinate2D(latitude: place!.getCoordinates().latitude, longitude: place!.getCoordinates().longitude)
                point.title = place!.getVenue()
                destination?.point = point
                
                //set the region
                let span = MKCoordinateSpanMake(0.01, 0.01)
                let region = MKCoordinateRegion(center: point.coordinate, span: span)
                destination?.region = region
            }
            
        }
    }
    

}

