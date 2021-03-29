import Foundation
import XCTest

class Solution1
{
    /*
     不使用加减乘除做加法
     解法：number1^number2 = number1+number2（不考虑进位），进位计算： (number1 & number2) << 1
     - Parameters:
        - number1: 数字1
        - number2: 数字2
     - Returns: 两数之和
     */
    func addOperation(number1:Int, number2:Int) -> Int
    {
        var number1 = number1
        var number2 = number2
        
        // 直到不产生进位为止
        while number2 != 0
        {
            // 1.不考虑进位对每一位相加
            let sum = number1 ^ number2
            
            // 2.向前产生一个进位
            let carry = (number1 & number2) << 1
            
            // 3.把前两个步骤的结果相加，相加的过程依然是重复前面两步
            number1 = sum
            number2 = carry
        }
        
        return number1
    }
}

class UnitTests: XCTestCase
{
    let solution1 = Solution1()
    override func setUp()
    {
        super.setUp()
    }
    
    func testCase1()
    {
        XCTAssertEqual(3, solution1.addOperation(number1: 1, number2: 2))
        XCTAssertEqual(1010, solution1.addOperation(number1: 111, number2: 899))
        XCTAssertEqual(-1, solution1.addOperation(number1: 1, number2: -2))
        XCTAssertEqual(3, solution1.addOperation(number1: 3, number2: 0))
        XCTAssertEqual(-4, solution1.addOperation(number1: -4, number2: 0))
        XCTAssertEqual(-10, solution1.addOperation(number1: -2, number2: -8))
    }
}

UnitTests.defaultTestSuite.run()
