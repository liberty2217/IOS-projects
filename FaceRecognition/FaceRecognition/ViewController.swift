//
//  ViewController.swift
//  FaceRecognition
//
//  Created by Баир Урусов on 09.04.2022.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        let authContext = LAContext()

        var error: NSError?
        print("evaluated")
        // asking only biometrics (face / touchId) with .deviceOwnerAuthenticationWithBiometrics
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            print("evaluated")
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you") { (success, error) in
                if success == true {
                    print("evaluated")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSignIn", sender: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorLabel.text = "Error"
                    }
                }
            }
        }
        
    }
    
}

