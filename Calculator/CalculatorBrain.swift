//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by David Yoon on 2021/07/11.
//

import Foundation

class CalculatorBrain {
    private var accumulator = 0.0
    
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String,Double> = [
        "π" : Double.pi,
        "e" : M_E,
    ]
    
    func performOperation(symbol: String) {
//        switch symbol {
//        case "π":
//            accumulator = Double.pi
//        case "√":
//            accumulator = sqrt(accumulator)
//        default:
//            break
//        }
        if let constant = operations[symbol]{
            accumulator = constant
        }
        
        
    }
    var result: Double {
        get {
            return accumulator
        }
    }
}
