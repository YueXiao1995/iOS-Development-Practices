// Yue Xiao 2019/03/03
// attribute： storage attribute， cumputation attribute
import UIKit

// storage attribute， a storage attribute is a variable or constant
// stored in the instance of certain class or structure
struct Number{
    var digit: Int // declare a variable
    let pi = 3.14159 // declare a constant
}
var n = Number(digit: 12345)  // create a instance
n.digit = 67  // modify the variable
print("\(n.digit)")
print("\(n.pi)")

// lazy attribute: the attribute which is empty until it is called
class sample {
    lazy var no = number()
}

class number {
    var name = "Hello World!"
}
var firstsample = sample()
print(firstsample.no.name)

// computation attribute
// doesn't store value, but offers a getter to get value, and a
// setter to set other attribute or variable
class sample2 {
    var no1 = 0.0, no2 = 0.0
    var length = 300.0, breadth = 150.0
    var middle: (Double, Double) {
        get {
            return (length / 2, breadth / 2)
        }
        set(axis){
            no1 = axis.0 - (length / 2)
            no2 = axis.1 - (breadth / 2)
        }
    }
}

var result = sample2()
print(result.middle) // (150.0, 75.0)
result.middle = (0.0, 10.0)
print(result.no1) // 0 - (300 / 2) = -150
print(result.no2) // 10 - (150 /2) = -65

// read only computation attribute
class film {
    var duration = 0.0
    var metaInfor: [String: String] {
        return ["duration": "\(self.duration)"]
    }
}
var movie = film()
movie.duration = 3.34
print(movie.metaInfor["duration"]!)

// attribute observer is used to observe and react to the change of attribute value
// willSet will be recall before the attribute update
// didSet will be recall after the arrtibute update
class Samplepgm {
    var counter: Int = 0 {
        willSet(newTotal) {
            print("number: \(newTotal)")
        }
        didSet{
            if counter > oldValue {
                print("add: \(counter - oldValue)")
            }
        }
    }
}
let NewCounter = Samplepgm()
NewCounter.counter = 100
NewCounter.counter = 800

// static attribute: can be defined in structure, enum and class
struct StudMarks {
    static let markCount = 97
    static var totalCount = 0
    var InternalMarks: Int = 0 {
        didSet {
            if InternalMarks > StudMarks.markCount {
                InternalMarks = StudMarks.markCount
            }
            if InternalMarks > StudMarks.totalCount {
                StudMarks.totalCount = InternalMarks
            }
        }
    }
}
var stud1Mark1 = StudMarks()
var stud1Mark2 = StudMarks()

stud1Mark1.InternalMarks = 98
print(stud1Mark1.InternalMarks)

stud1Mark2.InternalMarks = 87
print(stud1Mark2.InternalMarks)
