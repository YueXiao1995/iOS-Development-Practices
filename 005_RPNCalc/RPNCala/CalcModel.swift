//
//  CalcModel.swift
//  RPNCala
//
//  Created by YueXiao on 2019/3/26.
//  Copyright © 2019 COMP47390. All rights reserved.
//

import Foundation

class CalcModel {
    private var stack = [Double]()
    func pushOperand(_ operandValue: Double) -> Double? {
        stack.append(operandValue)
        return stack.last
    }
    
    func performOperation(_ operation: String) -> Double?{
        var result: Double?
        switch operation {
        case "+":
            //if stack.count >= 2 {
            //    displayValue = stack.removeLast() + stack.removeLast()
            //     pushOperand(nil)
            //}
            result = evaluateStack(+)
        case "×":
            result = evaluateStack(multiply)
        case "÷":
            result = evaluateStack({(op1: Double, op2: Double) -> Double in return op2/op1})
        case "-":
            //performOperation({(op1, op2) in op2-op1})
            result = evaluateStack({$1 - $0})
        case "±":
            result = evaluateStack({-$0})
        default:
            break
        }
        return result
    }
    
    private func evaluateStack(_ operation: (Double, Double) -> Double) -> Double? {
        if stack.count >= 2 {
            _ = pushOperand(operation(stack.removeLast(), stack.removeLast()))
        }
        return stack.last
    }

    private func evaluateStack(_ operation: (Double) -> Double) -> Double?{
        if stack.count >= 1 {
            _ = pushOperand(operation(stack.removeLast()))
        }
        return stack.last
    }
    
    
    func multiply(_ op1: Double, _ op2: Double) -> Double {
        return op1 * op2
    }
    
}
