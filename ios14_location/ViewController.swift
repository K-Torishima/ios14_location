//
//  ViewController.swift
//  ios14_location
//
//  Created by koji torishima on 2020/07/16.
// https://qiita.com/satoru_pripara/items/7dbaf59dc840d679751c

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var keido: UILabel!
    @IBOutlet weak var edo: UILabel!
    
    var locManager: CLLocationManager!
    var edoNow: String = ""
    var keidoNow: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocationM()
    }
    
    @IBAction func getLocation(_ sender: Any) {
        let status = CLLocationManager.authorizationStatus()
        let manager = locManager.accuracyAuthorization
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            print("許可した")
        case .notDetermined, .denied, .restricted:
            print("許可しない")
        default:
            print("Unhandled case")
        }
        
        switch manager {
        case .fullAccuracy:
            edo.text = "正確な緯度: \(edoNow)"
            keido.text = "正確な経度: \(keidoNow)"
            print(edoNow)
            print(keidoNow)
        case .reducedAccuracy:
            edo.text = "曖昧な緯度: \(edoNow)"
            keido.text = "曖昧な経度: \(keidoNow)"
        default:
            print("def")
        }
    }
    
    
    @IBAction func clearLabel(_ sender: Any) {
        keido.text = "クリアされました"
        edo.text = "クリアされました"
    }
    
    
    func setUpLocationM() {
        locManager = CLLocationManager()
        guard let locM = locManager else { return }
        locM.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .authorizedWhenInUse {
            locM.delegate = self
            locM.startUpdatingLocation()
        }
    }
    
    func alert() {
        let alertTitle = "位置情報取得が曖昧な情報となっています。"
        let alertMessage = "設定アプリの「プライバシー > 位置情報サービス」から変更してください。"
        let alert: UIAlertController = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle:  UIAlertController.Style.alert
        )
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        // UIAlertController に Action を追加
        alert.addAction(defaultAction)
        // Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    // 位置情報が更新された際、位置情報を格納
    //   - manager: ロケーションマネージャ
    //   - locations: 位置情報
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        // 位置情報を格納
        edoNow = String(latitude!)
        keidoNow = String(longitude!)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("フラグON")
        case .notDetermined, .denied, .restricted:
            print("フラグOFF")
        default:
            print("特に必要ない")
        }
        switch manager.accuracyAuthorization {
        case .fullAccuracy:
            print("正確な位置情報")
        case .reducedAccuracy:
            print("曖昧な位置情報")
            alert()
        default:
            print("デフォ")
        }
    }
}

