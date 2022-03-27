import Foundation
import XCTest

class Solution
{
    /**
     查找和为sum的连续正数序列
     - Parameters:
        - sum: 和
     - Returns: 和为sum的连续正数序列
     */
    func findContinuousSequence(_ sum: Int) -> [[Int]]
    {
        // 用两个数small和big分别表示序列的最小值和最大值，首先把small初始化为1，big 初始化为2
        var small = 1, big = 2
        
        // 因为这个序列至少要有两个数字，我们一直增加small到(1+sum)/2为止
        let middle = (1+sum)/2
        //print("sum=\(sum)，middle=\(middle)")
        
        // 计算序列的最小值和最大值之和
        var currentSum = small + big
        
        // 存储和为s的连续正数序列
        var result = [[Int]]()
        
        while small < middle
        {
            // 如果计算的和与期望值相同，则将序列加入结果中
            if currentSum == sum
            {
                result.append(Array(small...big))
            }
            
            // 如果从small到big的序列的和大于s，则可以从序列中去掉较小的值，也就是增大small的值
            while currentSum > sum && small < middle
            {
                currentSum -= small
                small += 1
  
                if currentSum == sum
                {
                    result.append(Array(small...big))
                }
            }
            
            // 如果从small到big的序列的和小于s，则可以增大big，让这个序列包含更多的数字
            // 接下来我们再增加big，重复前面的过程，可以找到第二个和为sum的连续序列
            big += 1
            currentSum += big
            
        }
        return result
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
        XCTAssertEqual(nil, solution.findContinuousSequence(1).first)
        XCTAssertEqual([1,2], solution.findContinuousSequence(3).first)
        XCTAssertEqual(nil, solution.findContinuousSequence(4).first)
        XCTAssertEqual([[2,3,4],[4,5]], solution.findContinuousSequence(9))
        XCTAssertEqual([[1, 2, 3, 4, 5], [4, 5, 6], [7, 8]], solution.findContinuousSequence(15))
        XCTAssertEqual([[9, 10, 11, 12, 13, 14, 15, 16], [18, 19, 20, 21, 22]], solution.findContinuousSequence(100))
    }
}

UnitTests.defaultTestSuite.run()
