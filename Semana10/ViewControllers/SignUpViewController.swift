import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        //firstnameTextField.text! = "Joel"
        //lastnameTextField.text! = "Joel"
        //userTextField.text! = "joelc"
        //passTextField.text! = "123456"
        //emailTextField.text! = "joelc@gmail.com"
        
        //STYLES
        btnBack.clipsToBounds = true
        btnBack.layer.cornerRadius = 15
        
        btnSignup.clipsToBounds = true
        btnSignup.layer.cornerRadius = 15
        
        firstnameTextField.layer.borderWidth = 1.5
        firstnameTextField.layer.cornerRadius = 15
        firstnameTextField.setLeftPaddingPoints(10)
        firstnameTextField.setRightPaddingPoints(10)
        
        lastnameTextField.layer.borderWidth = 1.5
        lastnameTextField.layer.cornerRadius = 15
        lastnameTextField.setLeftPaddingPoints(10)
        lastnameTextField.setRightPaddingPoints(10)
        
        userTextField.layer.borderWidth = 1.5
        userTextField.layer.cornerRadius = 15
        userTextField.setLeftPaddingPoints(10)
        userTextField.setRightPaddingPoints(10)
        
        passTextField.layer.borderWidth = 1.5
        passTextField.layer.cornerRadius = 15
        passTextField.setLeftPaddingPoints(10)
        passTextField.setRightPaddingPoints(10)
        
        emailTextField.layer.borderWidth = 1.5
        emailTextField.layer.cornerRadius = 15
        emailTextField.setLeftPaddingPoints(10)
        emailTextField.setRightPaddingPoints(10)
        
        birthdayTextField.layer.borderWidth = 1.5
        birthdayTextField.layer.cornerRadius = 15
        birthdayTextField.setLeftPaddingPoints(10)
        birthdayTextField.setRightPaddingPoints(10)
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        birthdayTextField.inputAccessoryView = toolbar
        birthdayTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        //datePicker.locale = Locale(identifier: "es")
    }
    
    @objc func donePressed(){
        let format = DateFormatter()
        format.dateStyle = .medium
        format.timeStyle = .none
        //format.locale = Locale(identifier: "es")
        birthdayTextField.text = format.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func onClickSignUp(_ sender: Any) {
        
        let firstname = firstnameTextField.text!
        let lastname = lastnameTextField.text!
        let username = userTextField.text!
        let pass = passTextField.text!
        let email = emailTextField.text!
        let birthday = birthdayTextField.text!
        
        if firstname.isEmpty || lastname.isEmpty || username.isEmpty || pass.isEmpty || email.isEmpty || birthday.isEmpty {
            let alert = UIAlertController(title: "Oops", message: "Complete todos los campos", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(alertButton)
            present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: email, password: pass, completion: { authResult, error in
                if error == nil {
                    print("SignUp OK")
                    Auth.auth().signIn(withEmail: email, password: pass, completion: { authResult, error  in
                        if error == nil {
                            guard let userID = (Auth.auth().currentUser?.uid) else { return }
                            let databaseRef = Database.database().reference()
                            let user = [
                                "firstname": firstname,
                                "lastname": lastname,
                                "username": username,
                                "email": email,
                                "birthday": birthday
                            ]
                            databaseRef.child("users").child(userID).setValue(user)
                            self.performSegue(withIdentifier: "nextsignup", sender: nil)
                        } else {
                            print("SignUp Error:\(String(describing: error))")
                        }
                    })
                } else {
                    print("SignUp Error:\(String(describing: error))")
                }
            })
        }
    }
}


