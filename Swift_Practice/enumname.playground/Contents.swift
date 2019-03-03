
// Yue Xiao 2019/03/03
// --------------------------- enumname -----------------------
import UIKit
// enum is a kind of data type, it is a set of data which have same features

enum DaysOfAWeek {
    case Sunday
    case Monday
    case Tuesday
    case Wednsday
    case Thursday
    case Friday
    case Saturday
}

var weekDay = DaysOfAWeek.Tuesday
print(weekDay)


// 相关值
// 不同数据类型, 值的创建基于常量或变量, 相关值是当你在创建一个基于枚举成员的新常量或变量时才会被设置，并且每次当你这么做得时候，它的值可以是不同的。
enum Student {
    case Name(String)
    case Mark(Int, Int, Int)
}

var studDetails = Student.Name("Runoob")
var studMarks = Student.Mark(98, 97, 69)
switch studMarks {
    case .Name(let studName):
        print("The name of student is: \(studName)")
    case .Mark(let Mark1, let Mark2, let Mark3):
        print("The marks of student are: \(Mark1), \(Mark2), \(Mark3)")
}


// 原始值
// 原始值可以是字符串，字符，或者任何整型值或浮点型值。每个原始值在它的枚举声明中必须是唯一的。
// 在原始值为整数的枚举时，不需要显式的为每一个成员赋值，Swift会自动为你赋值。
// 例如，当使用整数作为原始值时，隐式赋值的值依次递增1。如果第一个值没有被赋初值，将会被自动置为0。
enum Month: Int {
    case January = 1, February, March, April, May, June, July, August, September, October, November, December
}
let yearMonth = Month.May.rawValue
print("May: \(yearMonth)")
