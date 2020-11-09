//
//  PointsViewController.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 07/10/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import UIKit
import SafariServices

class PointsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewAddPoint: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var btAddPoint: UIButton!
    
    
    var points: [PointsInfo] = []
    var city: Cities?
    var cityID: CitiesInfo?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btAddPoint.layer.cornerRadius = 10
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero )

        // Do any additional setup after loading the view.
        title = city?.cityUf
        loadPoints()
    }
    
    //MARK: - Methods
    
    func loadPoints(){
        loading.startAnimating()
        PointsAPI.searchPoints(city: cityID?.id) { (pointInfo) in
            if let pointInfo = pointInfo{
                self.points += pointInfo
                print(pointInfo)
                DispatchQueue.main.async {
                self.loading.stopAnimating()
                self.viewAddPoint.isHidden = false
               self.tableView.reloadData()
           }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PointInfoViewController
        vc.city = city
        vc.point = points[tableView.indexPathForSelectedRow!.row]
    }
   
    //MARK: -Actions
    
    @IBAction func btAddPoint(_ sender: UIButton) {
          if let url = URL(string: "https://feirasorganicas.org.br/adicionar-local/") {
              let config = SFSafariViewController.Configuration()
              config.entersReaderIfAvailable = true

              let vc = SFSafariViewController(url: url, configuration: config)
              present(vc, animated: true)
          }
    }
    
    
    
    
    
}

    //MARK: UITableViewDelegate, UITableViewDataSource

extension PointsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = points.count == 0 ? viewAddPoint : nil
        print(points.count)
        return points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pointCell", for: indexPath)
       
        let point = points[indexPath.row]
        cell.textLabel?.text = point.title.rendered
        cell.detailTextLabel?.text = point.address
        return cell
    }
    
    
}
