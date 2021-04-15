import Foundation
import XCTest

class Solution
{
    func duplicate(_ nums: [Int]) -> Int?
    {
        // 所有数字都在1到 nums.count-1 大小范围内， min 和 max 表示这个范围
        var min = 1
        var max = nums.count - 1
        
        while min <= max
        {
            // 中间数
            let middle = (max - min) / 2 + min
            
            // 计算在指定范围内的数字个数（min~middle范围内）
            let countAtRange = nums.filter { $0 >= min && $0 <= middle }.count
            
            print("中间值：\(middle)，最小值：\(min)，最大值：\(max)")
        
            // 最终划分到只剩一个数字了，如果这个数字个数超过1个，那返回该重复数字，否则游戏Over
            if min == max
            {
                if countAtRange > 1
                {
                    return min
                }
                else
                {
                    break
                }
            }
            
            // 期望在指定范围内的数字个数（比如数组有8个元素，expectCount值就为4）
            let expectCount = middle - min + 1
            print("期望值：\(expectCount)，实际值：\(countAtRange)")
            
            // 二分查找的划分条件：实际值 > 期望值 说明了重复数字在哪个区域
            if countAtRange > expectCount
            {
                max = middle// 在前面的区域
            }
            else
            {
                min = middle + 1// 在后面的区域
            }
        }
        return nil
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
    
    // 数组中存在一个重复的数字
    func testCase1()
    {
        let nums = [3, 2, 1, 4, 4, 5, 6, 7]
        XCTAssertEqual(solution.duplicate(nums)!, 4)
    }
    
    // 数组中存在多个重复的数字
    func testCase2()
    {
        let nums = [2, 3, 5, 4, 3, 2, 6, 7]
        let duplications = [2,3]
        XCTAssertTrue(duplications.contains(solution.duplicate(nums)!))
    }
    
    // 重复数字是数组中最小的数字
    func testCase3()
    {
        let nums = [1, 2, 3, 4, 5, 6, 7, 1, 8]
        XCTAssertEqual(solution.duplicate(nums)!, 1)
    }

    // 重复数字是数组中最大的数字
    func testCase4()
    {
        let nums = [1, 7, 3, 4, 5, 6, 8, 2, 8]
        XCTAssertEqual(solution.duplicate(nums)!, 8)
    }

    // 数组中只有两个数字
    func testCase5()
    {
        let nums = [1, 1]
        XCTAssertEqual(solution.duplicate(nums)!, 1)
    }

    // 一个数字重复三次
    func testCase6()
    {
        let nums = [1, 2, 2, 6, 4, 5, 2]
        XCTAssertEqual(solution.duplicate(nums)!, 2)
    }

    // 数组中不存在重复的数字
    func testCase7()
    {
        let nums = [1, 2, 6, 4, 5, 3]
        XCTAssertNil(solution.duplicate(nums))
    }

    // 无效输入
    func testCase8()
    {
        let nums:[Int] = []
        XCTAssertNil(solution.duplicate(nums))
    }
}

UnitTests.defaultTestSuite.run()
