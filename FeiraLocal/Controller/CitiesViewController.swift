//
//  CitiesViewController.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 30/09/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import UIKit
import CoreLocation

protocol CitieFinderDelegate {
    func addCity(city: Cities)
}

enum MapMessageType {
       case locationError
       case authorizationWarning
   }

class CitiesViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var lbCityLocation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    
     var records:[Int] = Array()
     var cities: [Cities] = []
     var filtered: [Cities] = []
     var limit = 20
     var searchActive : Bool = false
     var delegate: CitieFinderDelegate!
     var locationManager = CLLocationManager()
     var ufLocation = ""
     var cityLocation = ""
    
    

    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        searchBar.delegate = self
        // LocationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // Popular tabela
        tableView.tableFooterView = UIView(frame: .zero )
               var index = 0
               while index < limit {
                   records.append(index)
                   index = index + 1
               }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.requestLocation()
        CitiesManager.loadCities(onComplete: { (cities) in
            self.cities = cities.sorted(by: <)
        }) { (error) in
            print(error)
        }
    }
    
    // MARK: - Methods
    
    
     @objc  func loadTable(){
       tableView.reloadData()
       }
       
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

         filtered = cities.filter{
            $0.City.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil
        }
         
              searchActive = !filtered.isEmpty
                print(searchActive)
              self.tableView.reloadData()
          }
    
    func showMessage(type: MapMessageType){
        let title = type == .authorizationWarning ? "Aviso" : "Erro"
        let message = type == .authorizationWarning ? "Para usar os recursos do App, você precisa permitir a localização" : "Não foi possível encontrar sua localização"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        if type == .authorizationWarning{
             let confirmAction = UIAlertAction(title: "Ir para Ajustes", style: .default) { (action) in
                if let appSettings = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
             }
             alert.addAction(confirmAction)
         }
         present(alert, animated: true, completion: nil)
         
     }
    

    
    // MARK: - Actions
    
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: UIButton) {
         if CLLocationManager.locationServicesEnabled(){
                   switch CLLocationManager.authorizationStatus() {
                   case .authorizedAlways, .authorizedWhenInUse:
                       let city = Cities(UF: ufLocation, City: cityLocation)
                       delegate.addCity(city: city)
                    dismiss(animated: true, completion: nil)
                   case .denied:
                       showMessage(type: .authorizationWarning)
                   case .notDetermined:
                       locationManager.requestWhenInUseAuthorization()
                   case .restricted:
                    showMessage(type: .locationError)
                   default:
                    showMessage(type: .locationError)
                   }
               }else {
            showMessage(type: .authorizationWarning)
               }
    }
    
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            print(filtered.count)
            return filtered.count
               }
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city: Cities
        if searchActive {
            city = filtered[indexPath.row]
        } else {
            city = cities[indexPath.row]
        }
        cell.textLabel?.text = city.cityUf
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectCity: Cities
        if searchActive {
           selectCity = filtered[indexPath.row]
         } else {
           selectCity = cities[indexPath.row]
        }
        let findCity = Cities(UF: selectCity.UF, City: selectCity.City)
        self.delegate!.addCity(city: findCity)
        dismiss(animated: true, completion: nil)
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == records.count - 1 {
            if records.count < cities.count {
                var index = records.count
                limit = index + 20
                while index < limit {
                    records.append(index)
                    index = index + 1
                }
               
                self.perform(#selector(loadTable))
            }
        }
    }
    
    
}

    // MARK: - UISearchBarDelegate

extension CitiesViewController: UISearchBarDelegate {
  
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         searchActive = false
     }
    
     func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
         searchActive = false
     }
    
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchActive = false
     }
    
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchActive = false
     }
}

// MARK: - CLLocationManagerDelegate


extension CitiesViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(lastLocation) { [weak self] (placemarks, error) in
                if error == nil {
                    if let firstLocation = placemarks?[0],
                        let cityName = firstLocation.locality,
                        let ufName = firstLocation.administrativeArea{ // get the city name
                        self?.cityLocation = cityName
                        self?.ufLocation = ufName
                        self?.lbCityLocation.text = cityName
                        self?.locationManager.stopUpdatingLocation()
                    }
                    
                } else {
                    self!.lbCityLocation.text = "Não localizado"
                }
            }
        }
    }
    
   
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
        case .notDetermined, .restricted, .denied:
            lbCityLocation.text = "Permitir localização"
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            print("dafault status")
        }
    }

    
}


