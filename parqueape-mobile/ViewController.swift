
import UIKit
import MapKit
import SDWebImage

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var photoFacebook: UIImageView!
    @IBOutlet weak var namesFacebook: UILabel!
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var maps: MKMapView!
    
    var names: String?
    var photo: String?
    
    var idGarage: Int16?
    var selectedAnnotation: CityLocation?
    let urlListParking = "https://fierce-fortress-85627.herokuapp.com/api/garages"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maps.delegate = self
        maps.showsUserLocation = true
        
        self.namesFacebook.text = names
        self.photoFacebook.sd_setImage(with: URL(string: photo as! String), completed: nil)
        self.photoFacebook.layer.borderWidth = 1
        self.photoFacebook.layer.masksToBounds = false
        self.photoFacebook.layer.borderColor = UIColor.black.cgColor
        self.photoFacebook.layer.cornerRadius = self.photoFacebook.frame.height/2
        self.photoFacebook.clipsToBounds = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        if !NetworkManager.isConnectedToNetwork(){
            return
        }
        
        NetworkManager.sharedInstance.callUrlWithCompletion(url: urlListParking, params: nil, completion: { (finished, response) in
            
            let coordinates : String = response["coordinates"] as! String
            let coordinatesArr : [String] = coordinates.components(separatedBy: ",")
            let lat : Double = (coordinatesArr[0] as NSString).doubleValue
            let long : Double = (coordinatesArr[1] as NSString).doubleValue
            
            let locationCity = CityLocation(title: response["title"] as! String, idGarage: response["id"] as! Int16, coordinate: CLLocationCoordinate2D(latitude: lat, longitude:long))
            
            self.maps.addAnnotation(locationCity)
            self.maps.addAnnotations([locationCity])
            
        }, method: .get)
        
    }

    @IBAction func localizame(_ sender: Any) {
        initLocation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initLocation() {
        
        let permiso = CLLocationManager.authorizationStatus()
        
        if permiso == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if permiso == .denied {
            alertLocation(tit: "Error de localización", men: "Actualmente tiene denegada la localización del dispositivo.")
        } else if permiso == .restricted {
            alertLocation(tit: "Error de localización", men: "Actualmente tiene restringida la localización del dispositivo.")
        } else {
            
            guard let currentCoordinate = locationManager.location?.coordinate else { return }
            
            let region = MKCoordinateRegionMakeWithDistance(currentCoordinate, 500 , 500)
            maps.setRegion(region, animated: true)
        }
    }
    func alertLocation(tit: String, men: String) {
        
        let alerta = UIAlertController(title: tit, message: men, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(action)
        self.present(alerta, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? CityLocation {
             self.idGarage = annotation.idGarage
             performSegue(withIdentifier: "garage", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "garage" {
            let destino = segue.destination as! DetailParkingViewController
            destino.idGarage = String(self.idGarage!)
            
        }
    }
    
}

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0])
    }
}
