
import UIKit
import FirebaseCore
import FirebaseFirestore



class AppTableViewController: UITableViewController {
 
    
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
    
    var listener: ListenerRegistration!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadBrinquedoList()
    }
    
    func loadBrinquedoList() {
        listener = firestore.collection(collection).order(by: "name", descending: 
            true).addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
            
            if let error = error {
                print(error)
            } else {
                guard let snapshot = snapshot else {return}
                    print("total: \(snapshot.documentChanges.count)" )
                if snapshot.metadata.isFromCache || snapshot.documentChanges.count > 0 {
                    self.showItemFrom(snapshot)
                }
                    
            }
        })
    }
    
    func showItemFrom(_ snapshot: QuerySnapshot) {
        brinquedosList.removeAll()
        for document in snapshot.documents {
           let data = document.data()
            if 
                let name = data["name"] as? String,
                let nameAddress = data["nameAddress"] as? String,
                let nameDoador = data["nameDoador"] as? String,
                let phone = data["phone"] as? String,
                let state = data["state"] as? String {
                //
                let BrinquedoItem = BrinquedoItem(id: document.documentID, nameB: name, nameDoador: nameAddress, nameAddress: nameDoador, phone: phone,	 state: state)
                brinquedosList.append(BrinquedoItem)
            }
        }
        tableView.reloadData()
    }
    
        
      /*
            //edit
            self.firestore.collection(self.collection).document(item.id).updateData(data)
      
            //add
            self.firestore.collection(self.collection).addDocument(data: data)
        
   */
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brinquedosList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let brinquedoItem = brinquedosList[indexPath.row]
        cell.textLabel?.text = brinquedoItem.nameB
        cell.detailTextLabel?.text = brinquedoItem.state

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let brinquedoItem = brinquedosList[indexPath.row]
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Deletar
            let brinquedoItem = brinquedosList[indexPath.row]
            firestore.collection(collection).document(brinquedoItem.id).delete()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
