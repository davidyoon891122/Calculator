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
    
    var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(Double.pi), //Double.pi,
        "e" : Operation.Constant(M_E), //M_E,
        "√" : Operation.UnaryOperation(sqrt),//sqrt,
        "cos" : Operation.UnaryOperation(cos), //cos
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double )
        case BinaryOperation
        case Equals
        
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation:
                break
            case .Equals:
                break
            default:
                break
            }
        }
        
        
    }
    var result: Double {
        get {
            return accumulator
        }
    }
}
