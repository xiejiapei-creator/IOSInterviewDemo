import Foundation
import XCTest

class Solution
{
    /**
     查找递增排序数组中缺失的那个数字
     解法：利用二分法查找，如果index和数据项相同，说明在右边部分，否则在左边部分
     - Parameters:
        - data: 递增数组
     - Returns: 缺失那个数字
     */
    func getMissingNumber(data: [Int]) -> Int?
    {
        guard data.count > 0 else { return nil }
        
        // 中间元素的下标
        var startIndex = 0
        var endIndex = data.count - 1
        
        while startIndex <= endIndex
        {
            let midIndex = (startIndex + endIndex)/2
            
            // 如果中间元素的值和下标相等，那么下一轮查找只需要查找右半边
            if midIndex == data[midIndex]
            {
                startIndex = midIndex + 1
            }
            else
            {
                // 如果中间元素的值和下标不相等，并且它前面一个元素和它的下标相等
                if midIndex > 0 && midIndex - 1 == data[midIndex - 1]
                {
                    // 这意味着这个中间的数字正好是第一个值和下标不相等的元素，它的下标就是在数组中不存在的数字
                    return midIndex
                }
                // 数组的首位置值和下标即不相等，缺失数字在首位置
                else if midIndex == 0
                {
                    return midIndex
                }
                // 如果中间元素的值和下标不相等，并且它前面一个元素和它的下标不相等，这意味着下一轮查找我们只需要在左半边查找即可
                else
                {
                    endIndex = midIndex - 1
                }
            }
        }
        
        // 查找到最后一个了，说明缺失的是最后一个
        if startIndex == data.count
        {
            return data.count
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
    
    // 缺失第一个数字0
    func testCase1()
    {
        let data = [1,2,3,4,5]
        XCTAssertEqual(0, solution.getMissingNumber(data: data))
    }
    
    // 缺失最后一个数字5
    func testCase2()
    {
        let data = [0,1,2,3,4]
        XCTAssertEqual(5, solution.getMissingNumber(data: data))
    }

    // 缺失中间的数字3
    func testCase3()
    {
        let data = [0,1,2,4,5]
        XCTAssertEqual(3, solution.getMissingNumber(data: data))
    }

    // 数组只有一个数字，缺失0
    func testCase4()
    {
        let data = [1]
        XCTAssertEqual(0, solution.getMissingNumber(data: data))
    }

    // 数组只有一个数字，缺失1
    func testCase5()
    {
        let data = [0]
        XCTAssertEqual(1, solution.getMissingNumber(data: data))
    }

    // 空数组
    func testCase6()
    {
        let data:[Int] = []
        XCTAssertEqual(nil, solution.getMissingNumber(data: data))
    }
}

UnitTests.defaultTestSuite.run()
