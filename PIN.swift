//
//  PIN.swift
//  metalDetector_UI
//
//  Created by Kevin Vallejo on 5/26/18.
//  Copyright © 2018 Vallejo. All rights reserved.
//

import Foundation
import MapKit

class PIN: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
