import Foundation
import XCTest
import SwiftUI

class Solution
{
    /**
     方法：将输入的整数与flag（初始值为1）进行按位与运算，如果大于0，则计数+1
          每次比较完将flag左移1位再比较，直到flag=0
     - Parameters:
        - num: 输入的整数
     - Returns: num的2进制表示中1的个数
     */
    func numberOf1_flagSolution(_ num: Int) -> Int
    {
        var flag = 1// flag（初始值为1）
        var count = 0// num的2进制表示中1的个数
        
        while flag != 0// 直到flag=0
        {
            // 进行按位与运算，如果大于0，则计数+1
            if (num & flag) > 0
            {
                count += 1
            }
            
            //  每次比较完将flag左移1位再比较
            flag = flag << 1
        }
        
        return count
    }
    
    /**
     方法：将整数 num-1 与 num 做与运算，会把该整数的最右边的1变成0
          那么1个整数二进制有多少个1就可以进行多少次这样操作
     - Parameters:
        - num: 输入的整数
     - Returns: num的2进制表示中1的个数
     */
    func numberOf1_operationCountSolution(_ num: Int) -> Int
    {
        var count = 0// num的2进制表示中1的个数
        var localNum = num
        
        while localNum > 0// 直到1全部变成0 即localNum为0
        {
            // 将整数 num-1 与 num 做与运算，会把该整数的最右边的1变成0
            localNum = localNum & (localNum - 1)
            
            // 那么1个整数二进制有多少个1就可以进行多少次这样操作
            count += 1
        }
        
        return count
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
    
    // 输入0
    func testCase1()
    {
        XCTAssertEqual(solution.numberOf1_flagSolution(0), 0)
        XCTAssertEqual(solution.numberOf1_operationCountSolution(0), 0)
    }
    
    //输入1
    func testCase2()
    {
        XCTAssertEqual(solution.numberOf1_flagSolution(1), 1)
        XCTAssertEqual(solution.numberOf1_operationCountSolution(1), 1)
    }
    
    // 输入10
    func testCase3()
    {
        XCTAssertEqual(solution.numberOf1_flagSolution(10), 2)
        XCTAssertEqual(solution.numberOf1_operationCountSolution(10), 2)
    }
    
    // 输入0x7FFFFFFF
    func testCase4()
    {
        XCTAssertEqual(solution.numberOf1_flagSolution(Int("7FFFFFFF", radix: 16)!), 31)
        XCTAssertEqual(solution.numberOf1_operationCountSolution(Int("7FFFFFFF", radix: 16)!), 31)
    }
    
    // 输入0xFFFFFFFF 负数
    func testCase5()
    {
        XCTAssertEqual(solution.numberOf1_flagSolution(Int("FFFFFFFF", radix: 16)!), 32)
        XCTAssertEqual(solution.numberOf1_operationCountSolution(Int("FFFFFFFF", radix: 16)!), 32)
    }
    
    // 输入0x80000000（负数），期待的输出是1
    func testCase6()
    {
        XCTAssertEqual(solution.numberOf1_flagSolution(Int("80000000", radix: 16)!), 1)
        XCTAssertEqual(solution.numberOf1_operationCountSolution(Int("80000000", radix: 16)!), 1)
    }
}

UnitTests.defaultTestSuite.run()



    

