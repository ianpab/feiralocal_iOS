//
//  Cities.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 28/09/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import Foundation

struct Cities: Codable, Equatable, Comparable {
        
    let UF: String
    let City: String
    
    var cityUf:String{
        return City + " - " + UF
    }
    
 static func < (lhs: Cities, rhs: Cities) -> Bool {
    return lhs.City < rhs.City
 }
}
