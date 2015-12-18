//
//  PlaceViewController.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 18-12-15.
//  Copyright © 2015 Alfredo Luco. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

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
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.Table.dequeueReusableCellWithIdentifier("placeCell")
        cell?.textLabel?.text = places[indexPath.row].getVenue()
        return cell!
    }
}
