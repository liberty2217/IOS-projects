//
//  ViewController.swift
//  segueExample
//
//  Created by Баир Урусов on 20.02.2022.
//

import UIKit

class ViewController: UIViewController {

    var userName = ""
    
    @IBOutlet weak var mainInput: UITextField!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func clickedBtnScreen(_ sender: Any) {
        
        userName = mainInput.text!
        performSegue(withIdentifier: "toSecondViewController", sender: nil)
    }
    
    @IBAction func clickedButtonScreenTwo(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondViewController" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.myName = userName
          
        }
    }
   
}

