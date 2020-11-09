//
//  ViewController.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 26/09/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
// https://feirasorganicas.org.br/wp-json/wp/v2/feiras?search=Taubate

import UIKit

class HomeViewController: UIViewController{

    @IBOutlet weak var tfSearchCity: UITextField!
    @IBOutlet weak var btSearchPoints: UIButton!
    @IBOutlet weak var viewCentral: UIView!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    
    var cities: Cities?
    var cityID: [CitiesInfo] = []

    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()

   // Visual botao
        btSearchPoints.layer.cornerRadius = 10
        viewCentral.layer.cornerRadius = 10
    }
    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Methods
    
 override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
      if segue.identifier == "cityFinder",
          let citiesViewController = segue.destination as? CitiesViewController {
          citiesViewController.delegate = self
      } else {
        let vc = segue.destination as! PointsViewController
        vc.city = cities
        vc.cityID = cityID.last
    }
  }
    
    func allowNext(){
        Loading.startAnimating()
        CitiesAPI.searchCities(city: cities!.cityUf) { (id) in
            if let id = id{
                self.cityID += id
                DispatchQueue.main.async {
                    self.Loading.stopAnimating()
                    self.btSearchPoints.isEnabled = true
                    self.btSearchPoints.alpha = 1.0
                }
            }
        }

    }
    
    // MARK: - Actions
    
    @IBAction func btSearchPoints(_ sender: UIButton) {

}
    
}
extension HomeViewController: CitieFinderDelegate{
    func addCity(city: Cities){
        tfSearchCity.text = city.cityUf
        cities = city
        allowNext()
        }
    
}


