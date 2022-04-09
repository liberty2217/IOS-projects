//
//  ViewController.swift
//  SignUpForm
//
//  Created by Баир Урусов on 21.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var repPasswordInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

  
    @IBAction func pressSignUp(_ sender: Any) {
        
        var message = "";
        
        if usernameInput.text?.count == 0 {
          message = "Please enter username"
        } else if passwordInput.text?.count == 0 || repPasswordInput.text?.count == 0  {
          message = "Please enter passwords"
        } else if passwordInput.text != repPasswordInput.text {
          message = "Passwords do no match"
        };
        
        if message.count == 0 {
            return
        }
        
        let alert = UIAlertController(title: "blah", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) { UIAlertAction in
            print("pressed")
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)

        
    }
    
}

