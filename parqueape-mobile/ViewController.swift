//
//  ViewController.swift
//  parqueape-mobile
//
//  Created by user140364 on 5/11/18.
//  Copyright © 2018 user140364. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    @IBOutlet weak var maps: MKMapView!
    var data: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maps.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        let sikkim=CityLocation(title: "Sikkim", coordinate: CLLocationCoordinate2D(latitude: 27.8236356, longitude:88.556531))
        let delhi = CityLocation(title: "Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.619570, longitude: 77.088104))
        let kashmir = CityLocation(title: "Kahmir", coordinate: CLLocationCoordinate2D(latitude: 34.1490875, longitude: 74.0789389))
        let gujrat = CityLocation(title: "Gujrat", coordinate: CLLocationCoordinate2D(latitude: 22.258652, longitude: 71.1923805))
        let kerala = CityLocation(title: "Kerala", coordinate: CLLocationCoordinate2D(latitude: 9.931233, longitude:76.267303))
        
        maps.addAnnotation(sikkim)
        maps.addAnnotation(delhi)
        maps.addAnnotation(kashmir)
        maps.addAnnotation(gujrat)
        maps.addAnnotation(kerala)
        
        maps.addAnnotations([sikkim, delhi, kashmir, gujrat, kerala])
        
        
    }

    @IBAction func localizame(_ sender: Any) {
        initLocation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initLocation() {
        
        let permiso = CLLocationManager.authorizationStatus()
        
        if permiso == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if permiso == .denied {
            alertLocation(tit: "Error de localización", men: "Actualmente tiene denegada la localización del dispositivo.")
        } else if permiso == .restricted {
            alertLocation(tit: "Error de localización", men: "Actualmente tiene restringida la localización del dispositivo.")
        } else {
            
            guard let currentCoordinate = locationManager.location?.coordinate else { return }
            
            let region = MKCoordinateRegionMakeWithDistance(currentCoordinate, 500 , 500)
            maps.setRegion(region, animated: true)
        }
    }
    func alertLocation(tit: String, men: String) {
        
        let alerta = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(action)
        self.present(alerta, animated: true, completion: nil)
    }
    
}

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0])
    }
}

