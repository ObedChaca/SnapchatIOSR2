import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userOrEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var btnBackl: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userOrEmailTextField.text="joelc2@gmail.com"
        passwordTextField.text="123456"
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 15
        btnBackl.clipsToBounds = true
        btnBackl.layer.cornerRadius = 15
        
        userOrEmailTextField.layer.borderWidth = 1.5
        userOrEmailTextField.layer.cornerRadius = 15
        userOrEmailTextField.setLeftPaddingPoints(10)
        userOrEmailTextField.setRightPaddingPoints(10)
        
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.setLeftPaddingPoints(10)
        passwordTextField.setRightPaddingPoints(10)
    }
    
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        
        let user = userOrEmailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: user, password: password) {(responseUser, error) in
            if error == nil {
                print("Login OK")
                self.userOrEmailTextField.text! = ""
                self.passwordTextField.text! = ""
                self.performSegue(withIdentifier: "seguehome", sender: nil)
            } else {
                let alert = UIAlertController(title: "Erro", message: "User or Password incorrect", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                print("Login Error")
            }
        }
        
    }
    
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
