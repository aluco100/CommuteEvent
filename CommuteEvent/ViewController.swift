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

class ViewController: UIViewController,CLLocationManagerDelegate,UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var contador: Int = 0
    var provider: Provider = Provider()
    var tweets:[JSONValue] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //instanciar al usuario
        var usuario: Usuario = Usuario(Nombre: "Alberto", Password: "alt001")
        let ubicacion: CLLocationCoordinate2D = usuario.getUbicacion()

    }

    @IBAction func getCoordenadas(sender: AnyObject) {
        if(contador == 0){
            provider.getAuth()
        }
        self.tableView.reloadData()
        contador++;
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tweets = provider.getTweets()
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = tweets[indexPath.row]["text"].string
        
        
        return cell
    }


}

