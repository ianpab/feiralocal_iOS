//
//  ViewController.swift
//  FeiraLocal
//
//  Created by Ian Pablo on 26/09/20.
//  Copyright © 2020 Ian Pablo. All rights reserved.
// https://feirasorganicas.org.br/wp-json/wp/v2/feiras?search=Taubate

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tfSearchCity: UITextField!
    @IBOutlet weak var btSearchPoints: UIButton!
    
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Cor de fundo gradiente
        view.setGradientBackground(colorOne: UIColor(named: "ligthGreen")!, colorTwo: UIColor(named: "darkGreen")!)
   // Visual botao
        btSearchPoints.layer.cornerRadius = 10
    }
    
    // MARK: - Actions
    
    @IBAction func btSearchPoints(_ sender: UIButton) {
    }
    

}
