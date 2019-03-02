// Yue Xiao 2019/03/02

// -------------------------- Closures --------------------------
import UIKit
// 全局函数和嵌套函数其实就是特殊的闭包
// 闭包的形式有：全局函数、嵌套函数、闭包表达式
/*
 {(parameters) -> return type in
    statements
 }
 */

// simple closures without parameters and return value
let studname = { print("Swift Closure Instance") }
studname()

// closures accept two parameters and return a value
let divide = {(value1: Int, value2: Int) -> Int in
    return value1 / value2
}
let result = divide(200, 20)
print(result)

// sorted(by:) method
let names = ["AT", "AE", "D", "S", "BE"]
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed1 = names.sorted( by: backwards )
print(reversed1)
var reversed2 = names.sorted( by: { $0 > $1 } )
print(reversed2)
var reversed3 = names.sorted( by: > )
print(reversed3)

// 尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用
var reversed4 = names.sorted(){ $0 > $1 }
print(reversed4)


// 闭包可以在其定义的上下文中捕获常量或变量
func makeIncrementor(forIncrement amount: Int) -> () -> Int{
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)
print(incrementByTen())
print(incrementByTen())
print(incrementByTen())

// incrementByTen 是一个指向闭包的引用
let alsoIncrementByTen = incrementByTen
print(alsoIncrementByTen())

