//
//  Place.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 02/10/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import Foundation
import MapKit

struct Place {
    //let cityFind = String
    
    static func getAddress(with placemark: CLPlacemark) -> String{
        var address = ""
        if let  city = placemark.locality{
            address = city
        }
        
        return address
    }
}
