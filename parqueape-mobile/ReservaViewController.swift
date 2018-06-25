//
//  ReservaViewController.swift
//  parqueape-mobile
//
//  Created by user140364 on 6/24/18.
//  Copyright © 2018 user140364. All rights reserved.
//

import UIKit

class ReservaViewController: UIViewController {
    
    var urlImageGarage: String?
    var titleGarage: String?

    @IBOutlet weak var reservaTitle: UILabel!
    @IBOutlet weak var imgGarage: UIImageView!
    
    @IBOutlet weak var numTarjeta: UITextField!
    @IBOutlet weak var montoTotal: UITextField!
    @IBOutlet weak var fechaReserva: UITextField!
    @IBOutlet weak var horaReserva: UITextField!
    @IBOutlet weak var cvc: UITextField!
    @IBOutlet weak var fechaVencTarjeta: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reservaTitle.text = titleGarage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func realizarReserva(_ sender: Any) {
        performSegue(withIdentifier: "reservaExitosa", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reservaExitosa" {
            let destino = segue.destination as! ReservaExitosaViewController
        }
    }
    
}
