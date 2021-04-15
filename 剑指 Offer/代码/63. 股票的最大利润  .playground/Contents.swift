import Foundation
import XCTest

class Solution
{
    /**
     获取股票的最大利润
     - Parameters:
        - numbers：股票价格数组
     - Returns: 最大利益
     */
    func maxProfit(_ numbers:[Int]) -> Int?
    {
        // 因为需要有买入和卖出价格，所以数组中必须至少有两个以上的数字
        guard numbers.count >= 2 else { return nil }
        
        // 保存之前的i-1个数字中的最小值，初始值为首位数字
        var minNumber = numbers[0]
        
        // 保存最大利润，初始值为第二位数字和首位数字之差
        var maxDifference = numbers[1] - minNumber
        
        // 从第三位数字开始计算
        for i in 2..<numbers.count
        {
            // 如果在扫描到数组中的第i个数字时，只要我们能够记住之前的i-1个数字中的最小值
            if numbers[i-1] < minNumber
            {
                minNumber = numbers[i-1]
            }
            
            // 就能算出在当前价位卖出时可能得到的最大利润
            if numbers[i] - minNumber > maxDifference
            {
                maxDifference = numbers[i] - minNumber
            }
        }
        return maxDifference
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
    
    // 价格随机
    func testCase1()
    {
        let numbers = [4,1,3,2,5]
        XCTAssertEqual(4, solution.maxProfit(numbers))
    }
    
    // 价格递增
    func testCase2()
    {
        let numbers = [1,2,4,7,11,16]
        XCTAssertEqual(15, solution.maxProfit(numbers))
    }

    // 价格递减
    func testCase3()
    {
        let numbers = [16,11,7,4,2,1]
        XCTAssertEqual(-1, solution.maxProfit(numbers))
    }

    // 价格不变
    func testCase4()
    {
        let numbers = [16,16,16,16,16]
        XCTAssertEqual(0, solution.maxProfit(numbers))
    }

    func testCase5()
    {
        let numbers = [9,11,5,7,16,1,4,2]
        XCTAssertEqual(11, solution.maxProfit(numbers))
    }

    func testCase6()
    {
        let numbers = [2,4]
        XCTAssertEqual(2, solution.maxProfit(numbers))
    }

    func testCase7()
    {
        let numbers = [4,2]
        XCTAssertEqual(-2, solution.maxProfit(numbers))
    }

    func testCase8()
    {
        let numbers = [Int]()
        XCTAssertEqual(nil, solution.maxProfit(numbers))
    }
}

UnitTests.defaultTestSuite.run()
