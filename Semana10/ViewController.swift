import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
        btnLogin.clipsToBounds = true
        btnLogin.layer.cornerRadius = 15
        
        btnSignUp.clipsToBounds = true
        btnSignUp.layer.cornerRadius = 15
    }

}

