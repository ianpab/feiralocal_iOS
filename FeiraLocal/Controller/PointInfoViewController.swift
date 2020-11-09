//
//  PointInfoViewController.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 11/10/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class PointInfoViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btAddress: UIButton!
    @IBOutlet weak var lbWeek: UILabel!
    @IBOutlet weak var btPointPage: UIButton!
    @IBOutlet weak var lbModified: UILabel!
    
    
    var city: Cities!
    var point: PointsInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btPointPage.layer.cornerRadius = 10
        title = city.cityUf
        
        self.setData()
        self.setMapa()

    }
    
    
    //MARK: - Methods
    
    
    // exibir informaçoes
    func setData(){
        lbTitle.text = point.title.rendered
        btAddress.setTitle(point.address, for: .normal)
        let schedule = point.horario.replacingOccurrences(of: "<br />", with: "\n")
        lbWeek.text = schedule.replacingOccurrences(of: "<br>", with: "\n")
        let modifiedDate = toDate(date: point.modified)
        lbModified.text = "Atualizado em: \(modifiedDate).\n A feira pode não existir mais ou ter mudado de endereço. Sempre verifique antes de conhecer."
    }
    
    // exibir mapa
    func setMapa(){
        mapView.mapType = .standard
        let initialLocation = CLLocation(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude)
        mapView.centerToLocation(initialLocation)

        let annot = PlaceAnnotation(title: point.title.rendered, coordinate: point.coordinate)
        mapView.addAnnotation(annot)
    }
    
    func toDate(date: String) -> String{
       let formatter = DateFormatter()
       formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatted = formatter.date(from: date ) ?? nil
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd/MM/yyyy"
        return formatter1.string(from: dateFormatted!)
       
    }
    
    //MARK: - Actions
    
    @IBAction func btPointPage(_ sender: UIButton) {
        if let url = URL(string: point.link) {
                     let config = SFSafariViewController.Configuration()
                     config.entersReaderIfAvailable = true

                     let vc = SFSafariViewController(url: url, configuration: config)
                     present(vc, animated: true)
                 }
    }
    
    @IBAction func routeMap(_ sender: UIButton) {
        if let url = URL(string: "https://waze.com/ul?ll=\(point.lat),\(point.lng)&navigate=yes") {
                   let config = SFSafariViewController.Configuration()
                   config.entersReaderIfAvailable = true

                   let vc = SFSafariViewController(url: url, configuration: config)
                   present(vc, animated: true)
               }
    }
    
   

}

    //MARK: - MKMapView
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
    setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: coordinateRegion), animated: true)
    let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
    setCameraZoomRange(zoomRange, animated: true)
  }
}

extension String {
func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = format
  guard let date = dateFormatter.date(from: self) else {
    preconditionFailure("Take a look to your format")
  }
  return date
    }
    
}
