//
//  PlaceAnnotation.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 12/10/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {

    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(
        title: String?,
        coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.coordinate = coordinate
    }
    
}
