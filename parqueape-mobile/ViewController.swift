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
    
    
    //let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let inicialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        //centerMapOnLocation(location: inicialLocation)
        // maps.showsUserLocation = true
        
        maps.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }

    @IBAction func localizame(_ sender: Any) {
        initLocation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //func centerMapOnLocation(location: CLLocation) {
    //    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
    //    maps.setRegion(coordinateRegion, animated: true)
    //}
    
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

