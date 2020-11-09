//
//  LocationManager.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 06/10/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager {
  
    class func loadCities(onComplete: @escaping (_ locations: [CLLocation]) -> Void, onError: @escaping (CitiesError) -> Void){  //closure

        if let lastLocation =  {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(lastLocation) { [weak self] (placemarks, error) in
            if error == nil {
                if let firstLocation = placemarks?[0],
                    let cityName = firstLocation.locality { // get the city name
                    self?.locationManager.stopUpdatingLocation()
                    self?.lbCityLocation.text = cityName
                }
                
            } else {
                self!.lbCityLocation.text = "Não localizado"
            }
        }
    }
    }
}


