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

class ViewController: UIViewController,CLLocationManagerDelegate,UITableViewDataSource, UITableViewDelegate,TweetsListener{
    
    @IBOutlet weak var tableView: UITableView!
    var contador: Int = 0
    var provider: Provider = Provider()
    var tweets:[JSONValue] = []
    var hashtags:[String] = []
    var users:[String] = []
    var places: Places = Places()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
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
        if(candidates.isEmpty){
            
        }else{
            places.getInternalCandidateList()
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


}

