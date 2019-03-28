//
//  CalcModel.swift
//  RPNCala
//
//  Created by YueXiao on 2019/3/26.
//  Copyright © 2019 COMP47390. All rights reserved.
//

import Foundation

class CalcModel {
    private var stack = [Operation]()
    
    enum Operation: CustomStringConvertible {

        
        case operand(Double)
        case unaryOperator(String, (Double) -> Double)
        case binaryOperator(String, (Double, Double) -> Double)
        var description: String {
            get {
                switch self {
                case .operand(let value):
                    return "\(value)"
                case .binaryOperator(let symbol, _):
                    return symbol
                    // case .unaryOperator(let value, _):
                //   return "\(value)"
                default:
                    return "unknown"
                }
            }
        }
    }
    
    var supportedOperators: [String: Operation]
    
    init() {
        func newOperator(_ operation: Operation){
            supportedOperators[operation.description] = operation
        }
        
        supportedOperators = [String: Operation]()
        newOperator(Operation.binaryOperator("+", +))
        newOperator(Operation.binaryOperator("-") {$1 - $0})
        newOperator(Operation.binaryOperator("×", *))
        newOperator(Operation.binaryOperator("÷") {$1 / $0})
        newOperator(Operation.binaryOperator("±", -))
        newOperator(Operation.unaryOperator("COS", cos))
        newOperator(Operation.unaryOperator("SIN", sin))
        newOperator(Operation.unaryOperator("√", sqrt))
        
        
    }
    
    func pushOperand(_ operandValue: Double) -> Double? {
        stack.append(Operation.operand(operandValue))
        return evaluateStack()
    }
    
    private func evaluateStack() -> Double? {
        let (result, leftOverStack) = evaluateStack(stack)
        if let evaluation = result {
            print("\(stack) = \(evaluation) with \(leftOverStack) left over")
        }
        return result
    }
    
    private func evaluateStack(_ stack: [Operation]) -> (result: Double?, leftOverStack: [Operation]) {
        if !stack.isEmpty {
            var leftOverStack = stack
            let operation = leftOverStack.removeLast()
            switch operation {
            case .operand(let operand):
                return (operand, leftOverStack)
            case .binaryOperator(_, let operation):
                let firstEval = evaluateStack(leftOverStack)
                if let firstEvalResult = firstEval.result {
                    let secondEval = evaluateStack(firstEval.leftOverStack)
                    if let secondEvalResult = secondEval.result {
                        return (operation(firstEvalResult, secondEvalResult), secondEval.leftOverStack)
                    }
                }
            default:
                break
            }
        }
        return (nil, stack)
    }
    
    func performOperation(_ symbol: String) -> Double?{
        if let operation = supportedOperators[symbol] {
            stack.append(operation)
        }
        return evaluateStack()
    }
    
    
    
    func multiply(_ op1: Double, _ op2: Double) -> Double {
        return op1 * op2
    }
    
}
