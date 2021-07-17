//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by David Yoon on 2021/07/11.
//

import Foundation

func multiply(op1: Double, op2: Double) -> Double {
    return op1 * op2
}

class CalculatorBrain {
    private var accumulator = 0.0
    
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    // 딕셔너리 value 값에는 상수, 함수, 2항 함수들이 들와야하는데 Double로 받으면 문제가 있으니 Enum으로 해당 값들을 모두 받게 구현
    // Dictionary<String,Enum(Operation)>
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(Double.pi), //Double.pi,
        "e" : Operation.Constant(M_E), //M_E,
        "√" : Operation.UnaryOperation(sqrt),//sqrt,
        "cos" : Operation.UnaryOperation(cos), //cos
        "±" : Operation.UnaryOperation({ -$0 }),
        "×" : Operation.BinaryOperation( { $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "−" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals,
    ]
    
    // 상수는 더블 일항연산자, 이항 연산자는 함수
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double )
        case BinaryOperation((Double,Double) -> Double)
        case Equals
        
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation() // 이항 연산자가 또 들어왔을 때 Equals와 같은 효과 나타나도록 추가 
                // 3 x 5 =  에서 3 은 firstOperand, binaryFunciton은 연산자에 따라 4칙 연산 함수  다음 상수 5 들어고  eqauls 연산자 들어오면 해당 실행
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
        
        
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            print("실행이 되나 ")
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator) // 연산함수( FO, 방금 들어온 값 )
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
