//
//  Points.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 07/10/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import Foundation
import MapKit

struct PointsInfo: Codable {
  
        let id: Int
        let modified: String
        let link: String
        let title: Rendered
        let uf: String
        let cidade: String
        let address: String
        let horario: String
        let lat: String
        let lng: String
    
    var coordinate: CLLocationCoordinate2D{
           return CLLocationCoordinate2D.init(latitude: Double((lat as NSString).doubleValue), longitude: Double((lng as NSString).doubleValue))

    }
}

struct Rendered:Codable {
    let rendered:String
}

struct Title: Codable {
    let rendered: String
}
