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
    
    //    lazy var mapView: MKMapView = {
    //        let mapView = MKMapView()
    //        mapView.frame = CGRect(x: .zero, y: .zero, width: view.frame.size.width, height: view.frame.size.height - 10 )
    //        mapView.mapType = MKMapType.standard
    //        mapView.isZoomEnabled = true
    //        mapView.isScrollEnabled = true
    //        return mapView
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.startUpdatingLocation()
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        //        mapView.center = view.center
        //        view.addSubview(mapView)
        getLocation()
    }
    
    func getLocation() {
        locManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch locManager.authorizationStatus() {
            case .authorizedWhenInUse:
                locManager.startUpdatingLocation()
            case .notDetermined:
                print("許可してません")
            default:
                break
            }
            switch locManager.accuracyAuthorization {
            case .fullAccuracy:
                // 一回許可したら常に許可しなくても良い
                // 最初の一回だけ
                print("正確な位置情報を許可")
            case .reducedAccuracy:
                // 一回正確な許可をされない場合ずっと正確ではない。
                print("正確な位置情報でない")
            default:
                print("どっちでもない")
            }
        }
    }
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lonStr = (locations.last?.coordinate.longitude.description)!
        let latStr = (locations.last?.coordinate.latitude.description)!
        switch locManager.accuracyAuthorization {
        case .fullAccuracy:
            keido.text = lonStr
            edo.text = latStr
            print("正確lon: " + lonStr)
            print("正確lat: " + latStr)
        case .reducedAccuracy:
            print("曖昧lon: " + lonStr)
            print("曖昧lat: " + latStr)
        default:
            break
            
        }
        
        for location in locations {
            let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let span = MKCoordinateSpan()
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            mapView.addAnnotation(annotation)
            
        }
    }
}


//#if DEBUG
//import SwiftUI
//
//struct VCPreview: PreviewProvider {
//    static var previews: some View {
//        ViewController()
//            .toPreview()
//            .previewDevice("iPhone 11 Pro Max")
//    }
//}
//
//#endif
