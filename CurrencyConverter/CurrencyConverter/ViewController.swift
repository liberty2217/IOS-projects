//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Баир Урусов on 09.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serialization
        
        // 1) Request & Session
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=48c11acd33a47d93909bd7fcf9968b31")
        
        let session = URLSession.shared
        
        // closure
        let task = session.dataTask(with: url!) { data, response, error in
            
            // error handler
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
              
                let okayButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okayButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                // result handler
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                // we can obtain data if its type is defined correctly (as? Double)
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                            }
                        }
                        
                        // repsonse above looks like an js object (not dictionary): { base = EUR; date = "2022-04-10"; rates = { AED = "3.12312"; AFN = "95.23423"...}
                        
                    } catch {
                        print("error")
                    }
                }
            }
        }
        
        task.resume()
    }
    
}

