//  Created by YueXiao on 2019/2/28.

//------------------------------------ Array ------------------------------------v
import UIKit
// *** create array ***
// var someArray = [SomeType](repeating: InitialValue, count: NumbeOfElements)
var intArray_1 = [Int](repeating: 0, count: 3)
print("Int Array_1: \(intArray_1)")

var intArray_2:[Int] = [10, 20, 30]
print("Int Array_2: \(intArray_2)")


// *** access array ***
var firstIntOfArray = intArray_2[0]
print("First value in Array_2: \(intArray_2)")

// *** edit array ***
// add element
var intArray_3 = [Int]()
intArray_3.append(20)
intArray_3.append(10)
intArray_3 += [0]
print("Int Array_3: \(intArray_3)")
// edit element by index
intArray_3[2] = 30
print("Int Array_3: \(intArray_3)")

// *** work through a array ***
var nameArray = [String]()
nameArray.append("David")
nameArray.append("Jack")
nameArray.append("Amy")
for item in nameArray {
    print(item)
}

for (index, item) in nameArray.enumerated() {
    print("The name in index = \(index) is \(item)")
}

// ** combaine two arrays **
var intArray_4 = [Int](repeating: 2, count: 2)
var intArray_5 = [Int](repeating: 1, count: 2)
var intArray_6 = intArray_4 + intArray_5
print("The combination of two arrays: \(intArray_6)")

// the count attribute of array
var numOfItem = intArray_6.count
print("Number of items in intArray_6: \(numOfItem) ")

// the isEmpty attribute of array
var intArray_7 = [Int]()
print("Is intArray_6 empty \(intArray_6.isEmpty)")
print("Is intArray_7 empty: \(intArray_7.isEmpty)")
