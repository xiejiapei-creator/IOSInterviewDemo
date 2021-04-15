import Foundation
import XCTest

class Solution
{
    /**
     求数字翻译成字符串的方法种数
     解法：从数字的右边往左边进行递归计算，消除重复计算的问题
     - Parameters:
        - number: 数字
     - Returns: 翻译方法种数
     */
    func getTranslationCount(_ number: Int) -> Int
    {
        if number < 0 { return 0 }
        return getTranslationCountCore(String(number).map{ Int(String($0))! })
    }
    
    /**
     求数字翻译成字符串的方法种数
     - Parameters:
        - nums: 数字的各位拆成的数组
     - Returns: 翻译方法种数
     */
    private func getTranslationCountCore(_ nums: [Int]) -> Int
    {
        // counts[i] 表示第i位到个位数组成数字的翻译方法次数
        var counts: [Int:Int] = [:]
        for index in stride(from: nums.count - 1, through: 0, by: -1)
        {
            var count = 0
            if index < nums.count - 1
            {
                count = counts[index + 1]!
            }
            else
            {
                count = 1
            }
            
            if index < nums.count - 1
            {
                let digit1 = nums[index]
                let digit2 = nums[index + 1]
                let converted = digit1 * 10 + digit2
                if converted >= 10 && converted <= 25
                {
                    if index < nums.count - 2
                    {
                        count += counts[index + 2]!
                    }
                    else
                    {
                        count += 1
                    }
                }
            }
            counts[index] = count
        }
        return counts[0]!
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
    
    func testCase1()
    {
        XCTAssertEqual(1, solution.getTranslationCount(0))
        XCTAssertEqual(2, solution.getTranslationCount(10))
        XCTAssertEqual(3, solution.getTranslationCount(125))
        XCTAssertEqual(2, solution.getTranslationCount(126))
        XCTAssertEqual(1, solution.getTranslationCount(426))
        XCTAssertEqual(2, solution.getTranslationCount(100))
        XCTAssertEqual(2, solution.getTranslationCount(101))
        XCTAssertEqual(5, solution.getTranslationCount(12258))
        XCTAssertEqual(0, solution.getTranslationCount(-100))
    }
}

UnitTests.defaultTestSuite.run()
