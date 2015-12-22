//
//  PlaceViewController.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 18-12-15.
//  Copyright © 2015 Alfredo Luco. All rights reserved.
//

import UIKit
import MapKit

class PlaceViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var Alert: UILabel!
    @IBOutlet weak var Table: UITableView!
    var places: [CandidateLocation] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(patternImage: UIImage(named: "background.jpg")!)
        
        self.Table.delegate = self
        self.Table.dataSource = self
        
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.Table.dequeueReusableCellWithIdentifier("placeCell")
        cell?.textLabel?.text = places[indexPath.row].getVenue()
        return cell!
    }
    
    func isTheresPlaces()->Void{
        if(self.places.count == 0){
            self.Alert.hidden = false
            Alert.text = "There's no places yet"
        }else{
            Alert.hidden = true
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "placeSegue"){
            let indexPath = self.Table.indexPathForSelectedRow
            let placeSelected = places[(indexPath?.row)!] 
            let destination = segue.destinationViewController as? MapViewController
            
            let point : MKPointAnnotation = MKPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: placeSelected.getCoordinates().latitude, longitude: placeSelected.getCoordinates().longitude)
            point.title = placeSelected.getVenue()
            destination?.point = point
            
            //set the region
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegion(center: point.coordinate, span: span)
            destination?.region = region
            
        }
    }
}
