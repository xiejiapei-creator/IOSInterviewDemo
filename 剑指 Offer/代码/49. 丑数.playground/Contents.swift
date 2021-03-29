import Foundation
import XCTest

class Solution
{
    /**
     计算丑数
     解法：从0开始遍历判断是否丑数，直到计算到index个
     - Parameters:
        - index: 返回第index个丑数
     - Returns: 丑数
     */
    func getUglyNumber_Solution1(_ index: Int) -> Int
    {
        // 异常输入
        guard index > 0 else {
            return 0
        }
        
        // 丑数个数
        var uglyCount = 0
        
        // 用于判断是否是丑数的数字
        var number = 0
        
        // 从0开始遍历判断是否丑数，直到计算到index个
        while uglyCount < index
        {
            // 判断下一个数字
            number += 1
            
            // 如果是丑数就将丑数个数+1
            if isUglyNumber(number)
            {
                uglyCount += 1
            }
        }
        
        return number
    }
    
    // 判断一个数字是否是丑数
    func isUglyNumber(_ number: Int) -> Bool
    {
        var number = number
        
        // 丑数能够被2 || 3 || 5除尽
        // 10会被2先整除为5，再被5整除为1
        while number % 2 == 0
        {
            number = number / 2
        }
        
        while number % 3 == 0
        {
            number = number / 3
        }
        
        while number % 5 == 0
        {
            number = number / 5
        }
        
        // 余1说明是丑数，习惯上我们把1当做第一个丑数
        return number == 1 ? true : false
    }
    
    /**
     计算丑数
     解法：根据已知的丑数，*2、*3、*5等方式计算下一个丑数
     - Parameters:
        - index: 返回第index个丑数
     - Returns: 返回第index个丑数
     */
    func getUglyNumber_Solution2(_ index: Int) -> Int
    {
        // 异常输入
        guard index > 0 else {
            return 0
        }
        
        // 创建一个数组，里面的数字是排好序的丑数，每个丑数都是前面的丑数乘以2、3或者5得到的
        var uglyNumberArray = [Int]()
        // 习惯上我们把1当做第一个丑数
        uglyNumberArray.append(1)
        
        // 下一个丑数的位置
        var nextUglyNumberIndex = 1
        
        // 存在某一个丑数T₂(T₃和T₅)，排在它之前的每个丑数乘以2(3和5)得到的结果都会小于已有最大的丑数，在它之后的每个丑数乘以2(3和5)得到的结果都会太大
        var multiply2Index = 0, multiply3Index = 0, multiply5Index = 0
        
        // 直到找到第index个丑数
        while nextUglyNumberIndex < index
        {
            // 因为我们希望丑数是按从小到大的顺序生成的，所以我们只需要第一个大于M的结果，即下一个丑数应该是M₂、M₃和M₅这3个数的最小者
            let nextUglyNumber = min(uglyNumberArray[multiply2Index] * 2, uglyNumberArray[multiply3Index] * 3, uglyNumberArray[multiply5Index] * 5)
            
            // 将下一个丑数添加到丑数数组中
            uglyNumberArray.append(nextUglyNumber)
            
            // 记下这个丑数的位置，同时每次生成新的丑数的时候去更新这个T₂(T₃和T₅)即可
            while uglyNumberArray[multiply2Index] * 2 <= uglyNumberArray.last!
            {
                multiply2Index += 1
            }
            
            while uglyNumberArray[multiply3Index] * 3 <= uglyNumberArray.last!
            {
                multiply3Index += 1
            }
            
            while uglyNumberArray[multiply5Index] * 5 <= uglyNumberArray.last!
            {
                multiply5Index += 1
            }
            
            // 寻找下一个丑数
            nextUglyNumberIndex += 1
        }
        
        // 返回第index个丑数
        return uglyNumberArray.last!
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
        XCTAssertEqual(1, solution.getUglyNumber_Solution1(1))
        XCTAssertEqual(2, solution.getUglyNumber_Solution1(2))
        XCTAssertEqual(3, solution.getUglyNumber_Solution1(3))
        XCTAssertEqual(4, solution.getUglyNumber_Solution1(4))
        XCTAssertEqual(5, solution.getUglyNumber_Solution1(5))
        XCTAssertEqual(6, solution.getUglyNumber_Solution1(6))
        XCTAssertEqual(8, solution.getUglyNumber_Solution1(7))
        XCTAssertEqual(9, solution.getUglyNumber_Solution1(8))
        XCTAssertEqual(10, solution.getUglyNumber_Solution1(9))
        XCTAssertEqual(12, solution.getUglyNumber_Solution1(10))
        XCTAssertEqual(15, solution.getUglyNumber_Solution1(11))
        //XCTAssertEqual(859963392, solution.getUglyNumber_Solution1(1500))// 太耗时了
    }
    
    func testCase2()
    {
        XCTAssertEqual(1, solution.getUglyNumber_Solution2(1))
        XCTAssertEqual(2, solution.getUglyNumber_Solution2(2))
        XCTAssertEqual(3, solution.getUglyNumber_Solution2(3))
        XCTAssertEqual(4, solution.getUglyNumber_Solution2(4))
        XCTAssertEqual(5, solution.getUglyNumber_Solution2(5))
        XCTAssertEqual(6, solution.getUglyNumber_Solution2(6))
        XCTAssertEqual(8, solution.getUglyNumber_Solution2(7))
        XCTAssertEqual(9, solution.getUglyNumber_Solution2(8))
        XCTAssertEqual(10, solution.getUglyNumber_Solution2(9))
        XCTAssertEqual(12, solution.getUglyNumber_Solution2(10))
        XCTAssertEqual(15, solution.getUglyNumber_Solution2(11))
        XCTAssertEqual(859963392, solution.getUglyNumber_Solution2(1500))
    }
}

UnitTests.defaultTestSuite.run()
