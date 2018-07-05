import UIKit
import FacebookLogin
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var imageUserFB: UIImageView!
    
    var dict : [String : AnyObject]!
    var names: String = ""
    var photo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageUserFB.image = UIImage(named: "ImageFB")
        
        loginButton.delegate = self
        let title = (FBSDKAccessToken.current() == nil) ? NSAttributedString(string:"Inicia sesion con Facebook") : NSAttributedString(string:"Cerrar sesion")
        loginButton.setAttributedTitle(title, for: .normal)
        view.addSubview(loginButton)
        
        if (FBSDKAccessToken.current()) != nil {
            getFBUserData()
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let loginManager = LoginManager()
        
        
        if((FBSDKAccessToken.current()) == nil){
            loginManager.logIn(readPermissions: [ .publicProfile ], viewController: self) { (loginResult) in
                switch loginResult {
                case .failed(let error):
                    print(error)
                    print("UPSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS")
                case .cancelled:
                    print("User cancelled login.")
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    self.getFBUserData()
                }
            }
        } else {
            loginButton.setAttributedTitle(NSAttributedString(string:"Cerrar sesion"), for: .normal)
            self.getFBUserData()
        }
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        loginButton.setAttributedTitle(NSAttributedString(string:"Inicia sesion con Facebook"), for: .normal)
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFBUserData(){
        
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    self.showMapsView()
                }
            })
            
        }
    }
    
    func showMapsView() {
        performSegue(withIdentifier: "maps", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("entrooooooo")
        if segue.identifier == "maps" {
            let vc = segue.destination as! ViewController
            
            var data = self.dict["picture"] as! AnyObject
            var dataImage = data["data"] as! AnyObject
            
            vc.names = self.dict["name"] as! String
            vc.photo = dataImage["url"] as! String
        }
    }
}
