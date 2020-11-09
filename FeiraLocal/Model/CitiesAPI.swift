//
//  PointsREST.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 07/10/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import Foundation
import Alamofire

class CitiesAPI {
    
    static private let basePath = "https://feirasorganicas.org.br/wp-json/wp/v2/cidade?"
    
    class func searchCities(city: String?, onComplete: @escaping ([CitiesInfo]?) -> Void){
        let search: String
        if let city = city, !city.isEmpty {
            search = "slug=\(city.folding(options: .diacriticInsensitive, locale: nil).lowercased())"
        } else {
            search = ""
        }
        let url = basePath + search.replacingOccurrences(of: " ", with: "-")
        print(url)
        
        AF.request(url).responseDecodable(of: [CitiesInfo].self) { (response) in
            guard let citiesInfo = response.value else {
                onComplete(nil)
                return
            }
            onComplete(citiesInfo)
        }
    }
    
}
