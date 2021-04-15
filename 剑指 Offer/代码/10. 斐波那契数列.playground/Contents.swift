import Foundation
import XCTest

class Solution
{
    /**
     求斐波那契数列中的第n个元素的值（递归方式——效率低）
     - Parameters:
        - n: 第n个元素
     - Returns: 第n个斐波那契数列的值
     */
    func recursionFibonacci(_ n: Int) -> Int
    {
        if n <= 0 { return 0 }
        if n == 1 { return 1 }
        
        return recursionFibonacci(n - 1) + recursionFibonacci(n - 2)
    }
    
    /**
     求斐波那契数列中的第n个元素（循环方式——效率较高）
     - Parameters:
        - n: 第n个元素
     - Returns: 第n个斐波那契数列的值
     */
    func loopFibonacci(_ n: Int) -> Int
    {
        if n <= 0 { return 0 }
        if n == 1 { return 1 }
        
        var num1 = 0
        var num2 = 1
        
        for _ in 2...n
        {
            let sum = num1 + num2
            num1 = num2
            num2 = sum
        }
        
        return num2
    }
}

class UnitTests: XCTestCase
{
    var solution: Solution!
    
    override func setUp()
    {
        super.setUp()
        solution = Solution()
    }

    func testCase()
    {
        test(0, expected: 0)
        test(1, expected: 1)
        test(2, expected: 1)
        test(3, expected: 2)
        test(4, expected: 3)
        test(5, expected: 5)
        test(6, expected: 8)
        test(7, expected: 13)
        test(8, expected: 21)
        test(9, expected: 34)
        test(10, expected: 55)
        test(20, expected: 6765)
        //test(100, expected: 6765)
    }
    
    private func test(_ n: Int, expected: Int)
    {
        XCTAssertEqual(solution.loopFibonacci(n), expected)
        XCTAssertEqual(solution.recursionFibonacci(n), expected)
    }
}

UnitTests.defaultTestSuite.run()
