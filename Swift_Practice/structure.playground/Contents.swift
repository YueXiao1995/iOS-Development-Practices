// Yue Xiao 2019/03/03
// structure
// difference between structure and class:
// https://medium.com/one-two-swift/classes-和-structure-oop-和-pop-de4a4b4ffe4b
import UIKit

struct studentMarks {
    var mark1 = 100
    var mark2 = 78
    var mark3 = 98
}

let marks = studentMarks()
print("Mark2 is: \(marks.mark2)")

// create and init a structure and clone
struct MarkStruct {
    var mark: Int
    
    init(mark: Int) {
        self.mark = mark
    }
}
var aStruct = MarkStruct(mark: 98)
// clone the struct instance
var bStruct = aStruct
bStruct.mark = 97
print(aStruct.mark)
print(bStruct.mark)




