//
//  ViewController.swift
//  Calculator in Swift
//
//  Created by student on 17.11.2020.
//

import UIKit

class ViewController: UIViewController {

    var currentNumber: Double = 0
    var prevNumber: Double = 0
    var toggleValue: Bool = false
    var operation:Int = 0
    var isForbidden = false
    var fixedTo5: Double = 0
    var dotIsExist = false

    @IBOutlet weak var displayLabel: UILabel!
    
    func checkInt(number: Double) {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            displayLabel.text = String(Int(number))
        } else {
            displayLabel.text = String(number)
        }
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        if displayLabel.text!.count <= 10 && sender.tag != 20 {
            if toggleValue == true && isForbidden == false {
                displayLabel.text = String(sender.tag - 1)
                toggleValue = false
                dotIsExist = false
            }
            else if toggleValue == false && isForbidden == false {
                displayLabel.text = displayLabel.text! + String(sender.tag - 1)
            }
        } else if displayLabel.text!.count <= 9 && sender.tag == 20 {
            if toggleValue == false && isForbidden == false && dotIsExist == false {
                displayLabel.text = displayLabel.text! + "."
                dotIsExist = true
            }
        }
        if Double(displayLabel.text!) != nil {
            currentNumber = Double(displayLabel.text!)!
        }
    }
    
    @IBAction func mathOps(_ sender: UIButton) {
        if displayLabel.text != "" && sender.tag != 11 && sender.tag != 18 && isForbidden == false {
                if Double(displayLabel.text!) != nil {
                    prevNumber = Double(displayLabel.text!)!
                }
                switch sender.tag {
                    case 14:
                        displayLabel.text = "÷"
                    case 15:
                        displayLabel.text = "x"
                    case 16:
                        displayLabel.text = "-"
                    case 17:
                        displayLabel.text = "+"
                    case 12:
                        displayLabel.text = String(prevNumber / 100)
                    case 13:
                        if prevNumber >= 0 {
                            fixedTo5 = Double(round(100000 * sqrt(prevNumber)) / 100000)
                            checkInt(number: fixedTo5)
                        } else {
                            displayLabel.text = "Forbidden!"
                            isForbidden = true
                        }
                    case 19:
                        checkInt(number: -prevNumber)
                    default:
                        print("error")
                }
            operation = sender.tag
            toggleValue = true
        }
        else if sender.tag == 18 && isForbidden == false {
            switch operation {
                case  14:
                    if (currentNumber != 0) {
                        fixedTo5 = Double(round(100000 * (prevNumber / currentNumber)) / 100000)
                        checkInt(number: fixedTo5)
                    } else {
                        displayLabel.text = "Forbidden!"
                        isForbidden = true
                    }
                case 15:
                    fixedTo5 = Double(round(100000 * (prevNumber * currentNumber)) / 100000)
                    checkInt(number: fixedTo5)
                case 16:
                    fixedTo5 = Double(round(100000 * (prevNumber - currentNumber)) / 100000)
                    checkInt(number: fixedTo5)
                case 17:
                    fixedTo5 = Double(round(100000 * (prevNumber + currentNumber)) / 100000)
                    checkInt(number: fixedTo5)
                default:
                    print("error")
            }
        }
        else if sender.tag == 11 {
            displayLabel.text = ""
            prevNumber = 0
            currentNumber = 0
            operation = 0
            isForbidden = false
            dotIsExist = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = ""
    }
}

