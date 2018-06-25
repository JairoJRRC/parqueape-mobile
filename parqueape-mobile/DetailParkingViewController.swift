//
//  DetailParkingViewController.swift
//  parqueape-mobile
//
//  Created by user140364 on 6/24/18.
//  Copyright © 2018 user140364. All rights reserved.
//

import UIKit
import SDWebImage

class DetailParkingViewController: UIViewController {
    
    var idGarage: String?
    
    var urlParking = "https://fierce-fortress-85627.herokuapp.com/api/garage/"
    

    @IBOutlet weak var titleGarage: UILabel!
    @IBOutlet weak var imgGarage: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var tarifa: UILabel!
    @IBOutlet weak var sites: UILabel!
    
    @IBAction func reservar(_ sender: Any) {
        performSegue(withIdentifier: "reserva", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reserva" {
            let destino = segue.destination as! ReservaViewController
            destino.urlImageGarage = self.imgGarage.textInputContextIdentifier
            destino.titleGarage = self.titleGarage.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlParking += self.idGarage!

        if !NetworkManager.isConnectedToNetwork(){
            return
        }
        
        NetworkManager.sharedInstance.callUrlWithCompletion(url: urlParking, params: nil, completion: { (finished, response) in
            
            self.titleGarage.text = response["title"] as! String
            self.address.text = response["address"] as! String
            self.imgGarage.sd_setImage(with: URL(string: response["photo"] as! String), completed: nil)
            
        }, method: .get)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
