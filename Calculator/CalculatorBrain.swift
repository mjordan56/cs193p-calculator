//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Michael Jordan on 3/16/17.
//  Copyright © 2017 MichaelJordan. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: (value: Double?, description: String) = (nil, "") {
        didSet {
            print(accumulator.description)
        }
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "∛" : Operation.unaryOperation({pow($0, 1.0/3.0)}),     // Cubed root function
        "x²" : Operation.unaryOperation({$0 * $0}),
        "x³" : Operation.unaryOperation({$0 * $0 * $0}),
        "sin" : Operation.unaryOperation(sin),
        "cos" : Operation.unaryOperation(cos),
        "tan" : Operation.unaryOperation(tan),
        "log" : Operation.unaryOperation(log10),
        "ln" : Operation.unaryOperation(log),
        "±" : Operation.unaryOperation({-$0}),
        "×" : Operation.binaryOperation({$0 * $1}),
        "÷" : Operation.binaryOperation({$0 / $1}),
        "+" : Operation.binaryOperation({$0 + $1}),
        "−" : Operation.binaryOperation({$0 - $1}),
        "=" : Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = (value, "\(symbol)")
            case .unaryOperation(let function):
                if accumulator.value != nil {
                    let description : String
                    if resultIsPending {
                        description = pendingBinaryOperation!.description + "\(symbol)(\(accumulator.description))"
                        pendingBinaryOperation!.description = ""
                    }
                    else {
                        description = "\(symbol)(\(accumulator.description))"
                    }
                    accumulator = (function(accumulator.value!), description)
                }
            case .binaryOperation(let function):
                performPendingBinaryOperation()
                if accumulator.value != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function,
                                                                    firstOperand: accumulator.value!,
                                                                    description: "\(accumulator.description) \(symbol) ")
                    accumulator = (nil, pendingBinaryOperation!.description)
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator.value != nil {
            accumulator = (pendingBinaryOperation!.perform(with: accumulator.value!),
                           pendingBinaryOperation!.description + "\(accumulator.description)")
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    var resultIsPending: Bool {
        get {
            return pendingBinaryOperation != nil
        }
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        var description: String
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = (operand, "\(operand)")
    }
    
    var result: (value: Double?, description: String) {
        get {
            return accumulator
        }
    }
    
    mutating func reset() {
        accumulator = (nil, "")
        pendingBinaryOperation = nil
    }
}
