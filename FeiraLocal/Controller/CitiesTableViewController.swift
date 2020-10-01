////
////  CitiesTableViewController.swift
////  FeiraLocal
////
////  Created by Ian Pablo on 28/09/20.
////  Copyright © 2020 Ian Pablo. All rights reserved.
////
//
//import UIKit
//
//protocol CitieFinderDelegate {
//    func addCity(city: Cities)
//}
//
//class CitiesTableViewController: UITableViewController {
//
//    var records:[Int] = Array()
//    var cities: [Cities] = []
//    var filtered: [Cities] = []
//    var limit = 20
//    var searchActive : Bool = false
//    var delegate: CitieFinderDelegate!
//
//
//    
//    @IBOutlet weak var searchBar: UISearchBar!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.tableFooterView = UIView(frame: .zero )
//        var index = 0
//        while index < limit {
//            records.append(index)
//            index = index + 1
//        }
//        searchBar.delegate = self
//  
//
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        CitiesManager.loadCities(onComplete: { (cities) in
//            self.cities = cities.sorted(by: <)
//            
//        }) { (error) in
//            print(error)
//        }
//    }
//    
//    
//    // MARK: - Func
//  @objc  func loadTable(){
//    tableView.reloadData()
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//           filtered = cities.filter { cities in
//            cities.City.localizedCaseInsensitiveContains(searchText)
//           }
//      
//           searchActive = !filtered.isEmpty
//           self.tableView.reloadData()
//       }
//
//
//    // MARK: - Table view data source
//
// 
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        if searchActive {
//                   return filtered.count
//               }
//        return records.count
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        // Configure the cell...
//        let citie = cities[indexPath.row]
//        if searchActive {
//            cell.textLabel?.text = filtered[indexPath.row].cityUf
//               } else {
//        cell.textLabel?.text = citie.cityUf
//        }
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let city = cities[indexPath.row]
//       let findCity = Cities(UF: city.UF, City: city.City)
//
//        dismiss(animated: true, completion: {
//            self.delegate?.addCity(city: findCity)
//        })
//    }
//    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == records.count - 1 {
//            if records.count < cities.count {
//                var index = records.count
//                limit = index + 20
//                while index < limit {
//                    records.append(index)
//                    index = index + 1
//                }
//               
//                self.perform(#selector(loadTable))
//            }
//        }
//    }
//    
// // MARK: - Atcion
//    
//    @IBAction func close(_ sender: UIButton) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//
//}
//
//extension CitiesTableViewController: UISearchBarDelegate {
//  
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//         searchActive = true
//     }
//    
//     func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//         searchActive = false
//     }
//    
//     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//         searchActive = false
//     }
//    
//     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//         searchActive = false
//     }
//}
