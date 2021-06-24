import UIKit
import Firebase

class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    var url : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        elegirContactoBoton.isEnabled = false
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.black.cgColor
        //imageView.layer.cornerRadius = imageView.bounds.width / 2
        
        descripcionTextField.layer.borderWidth = 1.5
        descripcionTextField.layer.cornerRadius = 15
        descripcionTextField.setRightPaddingPoints(10)
        descripcionTextField.setLeftPaddingPoints(10)
        
        elegirContactoBoton.clipsToBounds = true
        elegirContactoBoton.layer.cornerRadius = 15
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        url = info[UIImagePickerController.InfoKey.imageURL] as? URL
        print(url!)
        imageView.backgroundColor = UIColor.clear
        elegirContactoBoton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        elegirContactoBoton.isEnabled = false
        uploadIMG(fileURL: url!)
    }
    
    func uploadIMG (fileURL : URL) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference().child("imagenes").child("\(imagenID).jpg")
        
        storageRef.putFile(from: fileURL, metadata: nil) { metadata, error in
            // guard let metadata = metadata else {return}
            storageRef.downloadURL { (url, error) in
                guard let url = url else { return }
                print(url)
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: url.absoluteString)
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! ElegirUsuarioViewController
        siguienteVC.imageURL = sender as! String
        siguienteVC.descrip = descripcionTextField.text!
        siguienteVC.imagenID = imagenID
    }
}
