

// ------------------------------ function -------------------------------
import UIKit
/*
func funcname(形参) -> returntype
{
    Statement1
    Statement2
        ……
    Statement N
    return parameters
}*/

// define and call a function

func getWebsite(site: String) -> String {
    return (site)
}
print(getWebsite(site: "www.google.com"))

// accept more than one parameters
func get_food(type: String, name: String) -> String {
    return type + name
}
print(get_food(type: "fruit:", name: "banbana"))

// return a tuple
func minMax(array: [Int]) -> (small: Int, Max: Int) {
    let intA = array[0]
    let intB = array[1]
    if intA > intB {
        return (intB, intA)
    } else {
        return (intA, intB)
    }
}
let ints = minMax(array: [1, 2])
print("The smaller value: \(ints.small), the bigger value: \(ints.Max)")

// external parameters and internal parameters
func getFood(foodA a: String, foodB b: String){
    print(a)
    print(b)
}
getFood(foodA: "dumplin", foodB: "hamburger")

// changeable parameters
func vari<N>(members: N...) {
    for i in members {
        print (i)
    }
}
vari(members: "Google", "Amazon", "Facebook")

// constant, variables and I/O parameters
// usually the parameters of a function is a constant, to manipulate we
//need to add "inout" before the parameter

func swapTwoIns(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var intA = 1; var intB = 2
print("intA is \(intA), intB is \(intB)")
swapTwoIns(&intA, &intB)
print("after swap: intA is \(intA), intB is \(intB)")

// use function type as variable
func sum(a: Int, b: Int) -> Int {
    return a + b
}
var addition: (Int, Int) -> Int = sum(a:b:)
print("5 + 7 = \(addition(5, 7))")

// use function type as parameter type , return type
func another(addition: (Int, Int) -> Int, a: Int, b: Int) {
    print("\(a) + \(b) = \(addition(a, b))")
}
another(addition: sum, a: 10, b: 20)

// nested function
func calcDecrement(forDecrement total: Int) -> () -> Int {
    var overallDecrement = 0
    
    func decrementer() -> Int {
        overallDecrement -= total
        return overallDecrement
    }
    return decrementer
}
let decrem = calcDecrement(forDecrement: 30)
print(decrem())
