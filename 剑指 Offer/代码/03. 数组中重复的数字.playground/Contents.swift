import Foundation
import XCTest

class Solution
{
    // 创建一个新集合
    func findRepeatNumberBySet(_ nums: [Int]) -> Int
    {
        var set = Set<Int>()
        
        for num in nums
        {
            if set.contains(num)
            {
                return num
            }
            
            set.insert(num)
        }
        
        return -1
    }
    
    /**
     查找整数数组中任一重复的数字
     - Parameters:
        - nums: 整数数组
     - Returns: Tuple(重复数字的索引和值)
     */
    func duplicate(_ nums: [Int]) -> (index: Int, num: Int)?
    {
        var nums = nums
        for index in 0 ..< nums.count
        {
            // 不相等就一直交换下去，相等就扫描下一个数字
            while nums[index] != index
            {
                // 找到重复数字就直接返回
                if nums[index] == nums[nums[index]]
                {
                    return (index,nums[index])
                }
                
                // 否则进行交换
                (nums[index], nums[nums[index]]) = (nums[nums[index]], nums[index])
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
    
    // 重复数字是数组中最小的数字
    func testCase1()
    {
        let nums = [2, 1, 3, 1, 4]
        XCTAssertEqual(solution.findRepeatNumberBySet(nums), 1)
        XCTAssertEqual(solution.duplicate(nums)!.num, 1)
    }

    // 重复数字是数组中最大的数字
    func testCase2()
    {
        let nums = [2, 4, 3, 1, 4]
        XCTAssertEqual(solution.findRepeatNumberBySet(nums), 4)
        XCTAssertEqual(solution.duplicate(nums)!.num, 4)
    }

    // 数组中存在多个重复的数字
    func testCase3()
    {
        let nums = [2, 4, 2, 1, 4]
        let duplications = [2,4]
        XCTAssertTrue(duplications.contains(solution.findRepeatNumberBySet(nums)))
        XCTAssertTrue(duplications.contains(solution.duplicate(nums)!.num))
    }
    
    // 数组中不存在重复的数字
    func testCase4()
    {
        let nums = [2, 1, 3, 0, 4]
        XCTAssertEqual(solution.findRepeatNumberBySet(nums), -1)
        XCTAssertNil(solution.duplicate(nums))
    }
    
    // 无效输入
    func testCase5()
    {
        let nums:[Int] = []
        XCTAssertEqual(solution.findRepeatNumberBySet(nums), -1)
        XCTAssertNil(solution.duplicate(nums))
    }
}

UnitTests.defaultTestSuite.run()



