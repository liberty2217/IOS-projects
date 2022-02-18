//
//  ViewController.swift
//  Calculator
//
//  Created by Баир Урусов on 13.02.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var fieldOne: UITextField!
    @IBOutlet weak var fieldTwo: UITextField!
    @IBOutlet weak var result: UILabel!
    
    var res = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func addValues(_ sender: Any) {
        if let num1 = Int(fieldOne.text!) {
            if let num2 = Int(fieldTwo.text!) {
                res = num1 + num2
                
                result.text = String(res)
            }
        }
               
    }
    
    
    @IBAction func subtractValues(_ sender: Any) {
        if let num1 = Int(fieldOne.text!) {
            if let num2 = Int(fieldTwo.text!) {
                res = num1 - num2
                
                result.text = String(res)
            }
        }
    }
    
    
    @IBAction func multiplyValues(_ sender: Any) {
        if let num1 = Int(fieldOne.text!) {
            if let num2 = Int(fieldTwo.text!) {
                res = num1 * num2
                
                result.text = String(res)
            }
        }
    }
    
    
    @IBAction func divideValues(_ sender: Any) {
        if let num1 = Int(fieldOne.text!) {
            if let num2 = Int(fieldTwo.text!) {
                res = num1 / num2
                
                result.text = String(res)
            }
        }
    }
    
}

