//
//  AboutUsViewController.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 21/10/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
//

import UIKit
import SafariServices

class AboutUsViewController: UIViewController {

    
    @IBOutlet weak var viewCentral: UIView!
    @IBOutlet weak var btSite: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCentral.layer.cornerRadius = 10
        btSite.layer.cornerRadius = 10
    }
    
    @IBAction func btSite(_ sender: UIButton) {
        
        if let url = URL(string: "https://feirasorganicas.org.br/") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    

}
