
import UIKit
import FirebaseCore
import FirebaseFirestore


class AppFormViewController: UIViewController {
    
    let collection = "brinquedosList"
    var brinquedosList: [BrinquedoItem] = []
    lazy var firestore: Firestore = {
        let settings = FirestoreSettings()
        //settings.cacheSettings
        settings.isPersistenceEnabled = true
        
        let firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }()

    @IBOutlet weak var textFieldBrinquedo: UITextField!
    @IBOutlet weak var textFieldDoador: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var segmentedControlGasType: UISegmentedControl!
    @IBOutlet weak var buttonAddEdit: UIButton!
    @IBOutlet weak var textFieldPhone: UITextField!
    
   
    var brinquedo: BrinquedoItem?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

            if let brinquedo = brinquedo {
                title = "Edição"
                //textFieldBrinquedo.text = data["name"] as? String
                textFieldDoador.text = brinquedo.nameDoador
                textFieldAddress.text = brinquedo.nameAddress
                textFieldPhone.text = brinquedo.phone
                //segmentedControlGasType.selectedSegmentIndex = brinquedo.state
                buttonAddEdit.setTitle("Alterar", for: .normal)
            }
        }
    
    
    
    @IBAction func save(_ sender: UIButton) {
        
    
    }
}
