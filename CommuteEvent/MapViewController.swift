//
//  MapViewController.swift
//  CommuteEvent
//
//  Created by Alfredo Luco on 20-12-15.
//  Copyright © 2015 Alfredo Luco. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var Map: MKMapView!
    
    var point : MKPointAnnotation = MKPointAnnotation()
    var region: MKCoordinateRegion = MKCoordinateRegion()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Map.addAnnotation(point)
        self.Map.setRegion(region, animated: true)


    }
}
