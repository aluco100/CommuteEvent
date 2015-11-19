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
    
    @IBOutlet weak var tableView: UITableView!
    
    //variables
    var trnql: Trnql = Trnql.sharedInstance
    var contador: Int = 0
    var provider: Provider = Provider()
    var tweets:[JSONValue] = []
    var hashtags:[String] = []
    var users:[String] = []
    var places: Places = Places()
    var radar: Radar = Radar()
    override func viewDidLoad() {
        super.viewDidLoad()
        //instanciar la tabla
        tableView.dataSource = self
        tableView.delegate = self
        
        //instanciar trnql
        let api_key = "159c7ac6-9e48-4144-88b7-85feb03b55c3"
        trnql.delegate = self
        trnql.setAPIKey(api_key)
        
        trnql.startSmartPlaces()
        
        
        //instanciar al usuario
        //let usuario: Usuario = Usuario(Nombre: "Alberto", Password: "alt001")
        //let ubicacion: CLLocationCoordinate2D = usuario.getUbicacion()
    }
    
    func onTweetsReload(tweets: [JSONValue]) -> Void{
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }

    @IBAction func getCoordenadas(sender: AnyObject) {
        if(contador == 0){
            provider.getAuth()
            provider.registerTweetsListener(self)
        }
        
        
        let candidates = places.getPlaces()
        let mngr: PlaceManager = PlaceManager(locations: candidates,radarInit: radar)
        mngr.catchingCandidates()
        
        if(candidates.isEmpty){
            
        }else{
            places.getInternalCandidateList()
        }
        
        let venues: [CandidateLocation] = mngr.getCandidatesLocations()
        for i in venues{
            print("Twitter: \(i.getTwitter()) Name: \(i.getVenue()) Coordinates: \(i.getCoordinates())")
        }
        
        contador++;
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tweets = provider.getTweets()
        hashtags = provider.getHashtags()
        users = provider.getUsers()
        //return hashtags.count
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        
        //cell.textLabel?.text = hashtags[indexPath.row]
        //cell.textLabel?.text = tweets[indexPath.row]["text"].string
        cell.textLabel?.text = users[indexPath.row]
        
        return cell
    }
    
    func smartPlacesChange(places: [PlaceEntry]?, error: NSError?) {
        for i in places!{
            let coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: i.getLatitude()!, longitude: i.getLongitude()!)
            radar.getNearlyPlaces(coordinate, callback: {() -> Void in
                let candidatos: [CandidateLocation] = (self.radar.getVenues())
                for i in candidatos{
                    let twitter: String = i.getTwitter()
                    self.provider.follow(twitter)
                }
                })
        }
    }


}

