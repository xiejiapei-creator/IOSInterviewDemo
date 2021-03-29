import Foundation
import XCTest

class Solution
{
    /**
     连续子数组的最大和
     - Parameters:
        - numbers: n个数的数组
     - Returns: 最大和
     */
    func findGreatestSumOfSubArray(_ numbers: [Int]) -> Int
    {
        // 数组为空
        if numbers.count == 0 { return 0 }
        
        // 累加的子数组和
        var currentSum = 0
        // 最大的子数组和，不能初始化为0而是要设置为最小，因为有些连续子数组的最大和可能为负数
        var maxSum = Int.min
        
        for number in numbers
        {
            // 如果之前累加和为负数，把这个负数与第i个数累加，得到的结果比第i个数字本身还要小则将之前累加的和抛弃掉重置为第i个数字
            if currentSum <= 0
            {
                currentSum = number
            }
            // 如果之前累加和为正数（或0），与第i个数字累加就得到以第i个数字结尾的子数组中所有数字的和
            else
            {
                currentSum = currentSum + number
            }
            
            // 如果更新后的累加和比最大值大则更新最大值，否则最大值保持不变
            if currentSum > maxSum
            {
                maxSum = currentSum
            }
        }
        
        // 返回连续子数组的最大和
        return maxSum
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
    
    // 有正数有负数
    func testCase1()
    {
        XCTAssertEqual(18, solution.findGreatestSumOfSubArray([1,-2,3,10,-4,7,2,-5]))
    }
    
    // 全是负数
    func testCase2()
    {
        XCTAssertEqual(-1, solution.findGreatestSumOfSubArray([-2,-8,-1,-5,-9]))
    }

    // 全是正数
    func testCase3()
    {
        XCTAssertEqual(25, solution.findGreatestSumOfSubArray([2,8,1,5,9]))
    }
}

UnitTests.defaultTestSuite.run()

 
