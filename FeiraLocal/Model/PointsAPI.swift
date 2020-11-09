//
//  PointsREST.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 07/10/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import Foundation
import Alamofire

class PointsAPI {
    
    static private let basePath = "https://feirasorganicas.org.br/wp-json/wp/v2/feiras?"
    
    class func searchPoints(city: Int?, onComplete: @escaping ([PointsInfo]?) -> Void){
        let search: String
        if let city = city {
          search = "cidade=\(city)"
        } else {
            search = ""
        }
        let url = basePath + search
        print(url)
        
        AF.request(url).responseDecodable(of: [PointsInfo].self) { (response) in
            guard let pointInfo = response.value else {
                onComplete(nil)
                return
            }
                print(pointInfo)
            onComplete(pointInfo)
        }
    }
    
}
