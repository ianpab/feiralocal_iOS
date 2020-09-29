//
//  CitiesManager.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 28/09/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import Foundation
import Alamofire

enum CitiesError{
    case noData
    case invalidJson
}



class CitiesManager {


    class func loadCities(onComplete: @escaping ([Cities]) -> Void, onError: @escaping (CitiesError) -> Void){  //closure
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json") else {
            onError(.invalidJson)
            return
        }
      do {
        let citiesData = try Data(contentsOf: url)
        let cities = try JSONDecoder().decode([Cities].self, from: citiesData)
         onComplete(cities)
      } catch  {
        onError(.noData)
         
      }
        
    }
      
}
