//
//  CityLocation.swift
//  parqueape-mobile
//
//  Created by user140364 on 6/24/18.
//  Copyright © 2018 user140364. All rights reserved.
//

import Foundation
import MapKit

class CityLocation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
    
}
