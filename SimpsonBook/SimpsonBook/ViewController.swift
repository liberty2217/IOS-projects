//
//  ViewController.swift
//  SimpsonBook
//
//  Created by Баир Урусов on 04.04.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var chosenSimpsonName = ""
    var chosenSimpsonJob = ""
    var chosenSimpsonImage = UIImage()

    
    @IBOutlet weak var tableView: UITableView!
        
    var mySimpsons = [Simpson]()
    var chosenSimpson : Simpson?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        let homer = Simpson(simpsonName: "Homer", simpsonJob: "Nuclear Safety", simpsonImage: UIImage(named: "homer")!)
        
        let marge = Simpson(simpsonName: "Marge", simpsonJob: "Housewife", simpsonImage: UIImage(named: "marge")!)
        
        let patty = Simpson(simpsonName: "Patty", simpsonJob: "Consultant", simpsonImage: UIImage(named: "patty")!)
        
        let selma = Simpson(simpsonName: "Selma", simpsonJob: "Waitress", simpsonImage: UIImage(named: "selma")!)
        
        mySimpsons.append(homer)
        mySimpsons.append(marge)
        mySimpsons.append(patty)
        mySimpsons.append(selma)
        
    }

    // cell appereance
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = mySimpsons[indexPath.row].name
        return cell
    }
    
    // cell number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySimpsons.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        chosenSimpson = mySimpsons[indexPath.row]
        self.performSegue(withIdentifier: "DetailsVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.selectedSimpson = chosenSimpson
        }
    }
    

}

