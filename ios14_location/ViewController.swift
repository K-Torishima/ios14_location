//
//  ViewController.swift
//  ios14_location
//
//  Created by koji torishima on 2020/07/16.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var keido: UILabel!
    @IBOutlet weak var edo: UILabel!
    
    var locManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
    
