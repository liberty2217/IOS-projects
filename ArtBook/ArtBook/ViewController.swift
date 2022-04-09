//
//  ViewController.swift
//  ArtBook
//
//  Created by Баир Урусов on 04.04.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // both array for showing cells (keeping "name" and "id" relativle) so nameArray[0] will correspond idArray[0]
    var nameArray = [String]()
    var idArray = [UUID]()
    
    // string and id of tapped (selected) row to pass to other VC to change interface (show details).
    var selectedPainting = ""
    var selectedPaintingId: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        getData()
    }
    
    // re-fetch data after adding new painting to CoreDataand going back to home VC
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    // fetch data from CoreData module
    @objc func getData() {

        // remove duplicates
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)

        // 1) apply to UIApplication and get context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // 2) make request to get data from CoreData ("database")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        // 3) get array as result of request and loop over this array to put these values into nameArray (UBE: since there is no map()?)
        do {
            let results = try context.fetch(fetchRequest)
            
            // swift supposes to put values in array by looping (we only need "name" to show text of cell and id to pass in other VC
            for result in results as! [NSManagedObject] {
                if let name = result.value(forKey: "name") as? String {
                    self.nameArray.append(name)
                }
                
                // we don't create new UUID - we just simply obtain it and add it to our array
                if let id = result.value(forKey: "id") as? UUID {
                    self.idArray.append(id)
                }
                
           // reload sections and rows in tableView
                self.tableView.reloadData()
            }
                    
        } catch {
            print("error")
        }
        
    }
    
    // action (for header button) to navigate to another VC
    @objc func addButtonClicked() {
        selectedPainting = ""
        performSegue(withIdentifier: "DetailsVC", sender: nil)
    }
    
    // number of cells in UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    // return UICell itself customizing them (adding "name" to cells)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    // navigate to another VC (without preparation for segue - it is defined below)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row]
        selectedPaintingId = idArray[indexPath.row]
        performSegue(withIdentifier: "DetailsVC", sender: nil)
    }
    
    // prepare to navigation to other DetailsVC and change its vars (class properties) to change interface
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenPainting = selectedPainting
            destinationVC.chosenPaintingId = selectedPaintingId
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            let idString = idArray[indexPath.row].uuidString
            
            // predicate is used for filtering fetch result (?)
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        
                        if let id = result.value(forKey: "id") as? UUID {
                            
                            if id == idArray[indexPath.row] {
                                context.delete(result)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                
                                do {
                                    try context.save()
                                } catch {
                                    print("error")
                                }
                                break
                            }
                        }
                    }
                }
            } catch {
                print("error")
            }
        }
    }
}

