//
//  ViewController.swift
//  Calculator
//
//  Created by David Yoon on 2021/07/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var display: UILabel!
    private var userIsInsTheMiddleOfTyping: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInsTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInsTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInsTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInsTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        
        displayValue = brain.result
    }
    
    
    
}

