//
//  ViewController.swift
//  Calculator
//
//  Created by Michael Jordan on 3/10/17.
//  Copyright © 2017 MichaelJordan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var inputSequence: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var userIsInTheMiddleOfTyping = false
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func touchClear() {
        brain.reset()
        userIsInTheMiddleOfTyping = false
        display.text = "0"
        inputSequence.text = " "
    }

    @IBAction func touchBackspace() {
        if display.text != nil && userIsInTheMiddleOfTyping {
            if display.text!.characters.count == 1 {
                display.text = "0"
                userIsInTheMiddleOfTyping = false
            }
            else {
                display.text!.characters.removeLast()
            }
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func touchDecimal() {
        let decimal = "."
        if userIsInTheMiddleOfTyping {
            if !display.text!.contains(decimal) {
                display.text = display.text! + decimal
            }
        }
        else {
            display.text = "0."
            userIsInTheMiddleOfTyping = true
        }
    }
    
    private var brain = CalculatorBrain()

    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }

        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result.value {
            displayValue = result
        }
        
        let resultStateIndicator = brain.resultIsPending ? "…" : "="
        inputSequence.text = "\(brain.result.description) \(resultStateIndicator)"
    }
}
