import Foundation
import XCTest

class Solution
{
    // 每个字符都是'0'~'9'之间的某一个字符，用来表示数字中的一位
    private let digitsDictionary:[Character] = ["0","1","2","3","4","5","6","7","8","9"]
    
    /**
     按顺序打印出从1最大的n位十进制数
     主要考察当n比较大时，longlong都不能表示的情况
     - Parameters:
        - number：最大的位数
     */
    func print1ToMaxOfDigits(_ number: Int)
    {
        // 意外情况
        if number <= 0
        {
            return
        }
        
        var characterArray: [Character] = Array(repeating: "0", count: number)
        for index in 0 ..< digitsDictionary.count
        {
            characterArray[0] = digitsDictionary[index]
            print1ToMaxOfDigitsCore(characterArray, index: 0)
        }
    }

    /**
     循环递归地替换numbers数组中的第index及之后的每个元素（字符）
     如果数组的最后一个元素也已经替换，则调用打印函数进行打印
     - Parameters:
        - numbers: 字符数组
        - index: 当前需要替换字符的数组索引
     */
    private func print1ToMaxOfDigitsCore(_ numbers:[Character], index: Int)
    {
        var localNumbers = numbers

        if index == localNumbers.count - 1
        {
            printNumber(localNumbers)// 00略过
            return
        }

        for i in 0 ..< digitsDictionary.count// 0～9
        {
            localNumbers[index + 1] = digitsDictionary[i]
            print1ToMaxOfDigitsCore(localNumbers, index: index + 1)
        }
    }
    
    /**
     打印字符数组里的所有字符，如果数组前几个字符是0，则忽略它们
     - Parameters:
        - nums：输入的字符数组
     */
    private func printNumber(_ numbers:[Character])
    {
        var isBeginning = true
        for character in numbers
        {
            if character == "0" && isBeginning
            {
                continue
            }
            else
            {
                isBeginning = false
                print(character, terminator:"")
            }
        }
        print("\n")
    }
}

class UnitTests: XCTestCase
{
    var solution: Solution!

    override func setUp() {
        super.setUp()
        solution = Solution()
    }

    func testCase1()
    {
        solution.print1ToMaxOfDigits(1)
    }
    
    func testCase2()
    {
        solution.print1ToMaxOfDigits(2)
    }

    func testCase3()
    {
        solution.print1ToMaxOfDigits(3)
    }

    func testCase4()
    {
        solution.print1ToMaxOfDigits(0)
    }

    func testCase5()
    {
        solution.print1ToMaxOfDigits(-1)
    }
}

UnitTests.defaultTestSuite.run()
