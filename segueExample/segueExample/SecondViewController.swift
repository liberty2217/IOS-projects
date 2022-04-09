//
//  SecondViewController.swift
//  segueExample
//
//  Created by Баир Урусов on 20.02.2022.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var inputLabel: UILabel!
    var myName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputLabel.text = myName
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
