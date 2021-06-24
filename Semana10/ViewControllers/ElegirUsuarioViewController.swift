import UIKit
import Firebase

class ElegirUsuarioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var usuarios : [Usuario] = []
    var imageURL = ""
    var descrip = ""
    var imagenID = ""
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.ref = Database.database().reference()
        self.ref.child("users").observe(DataEventType.childAdded, with: {(DataSnapshot) in
            let usuario = Usuario()
            usuario.email = (DataSnapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = DataSnapshot.key
            self.usuarios.append(usuario)
            self.tableView.reloadData()
            print(DataSnapshot)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(usuarios.count)
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
        //print(usuario)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuario = usuarios[indexPath.row]
        let snap = ["from":Auth.auth().currentUser!.email!, "description":descrip, "imageURL":imageURL, "imagenID":imagenID]
        self.ref = Database.database().reference()
        self.ref.child("users").child(usuario.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController?.popToRootViewController(animated: true)
    }
}
