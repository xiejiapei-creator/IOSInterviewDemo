import Foundation
import XCTest

class Solution
{
    /**
     旋转数组的最小数字
      - Parameters:
        - nums: 一个递增数组的旋转
      - Returns: 数组中最小的那个数字
     */
    func minArray(_ numbers: [Int]) -> Int
    {
        // 特例1：数组为空就直接返回
        if numbers.isEmpty
        {
            return -1
        }
        
        // 特例2与3：数组只有一个元素 || 将单调升序数组旋转0个元素，也就是获得单调升序数组本身
        if (numbers.count == 1) || (numbers.first! < numbers.last!)
        {
            // 最小值为第一个元素
            return numbers[0]
        }
        
        // 特例4：有重复的数字，并且重复的数字刚好是第一个数字和最后一个数字
        if (numbers.first! == numbers.last!)
        {
            // 此时，我们不得不采用顺序查找的方法寻找最小值
            var minNumer = numbers[0]
            for number in numbers
            {
                if number < minNumer
                {
                    minNumer = number
                }
            }
            return minNumer
        }
        
        var startIndex = 0// P1指针
        var endIndex = numbers.count - 1// P2指针
        while (startIndex != endIndex - 1)// P2指针和P1指针距离只有1是结束条件
        {
            let midIndex = startIndex + (endIndex - startIndex)/2// 中间数字的位置
            
            if (numbers[startIndex] < numbers[midIndex])// P1指针指向的值小于中间数
            {
                // 最小值一定在中间数后面，所以将P1指针指向中间数，并重新计算中间数
                startIndex = midIndex
            }
            
            if (numbers[endIndex] > numbers[midIndex])// P2指针指向的值大于中间数
            {
                // 最小值一定在中间数前面，所以将P2指针指向中间数，并重新计算中间数
                endIndex = midIndex
            }
        }
        
        // 结束时P2指针指向的值就是最小值
        return numbers[endIndex]
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
    
    // 典型输入
    func testCase1()
    {
        let nums = [3, 4, 5, 1, 2]
        XCTAssertEqual(solution.minArray(nums), 1)
    }
    
    // 有重复数字，并且重复的数字刚好是最小的数字
    func testCase2()
    {
        let nums = [3, 4, 5, 1, 1, 2]
        XCTAssertEqual(solution.minArray(nums), 1)
    }
    
    // 有重复数字，但重复的数字不是第一个数字和最后一个数字
    func testCase3()
    {
        let nums = [3, 4, 5, 1, 2, 2]
        XCTAssertEqual(solution.minArray(nums), 1)
    }
    
    // 有重复的数字，并且重复的数字刚好是第一个数字和最后一个数字
    func testCase4()
    {
        let nums = [1, 0, 1, 1, 1]
        XCTAssertEqual(solution.minArray(nums), 0)
    }
    
    // 将单调升序数组旋转0个元素，也就是获得单调升序数组本身
    func testCase5()
    {
        let nums = [1, 2, 3, 4, 5]
        XCTAssertEqual(solution.minArray(nums), 1)
    }
    
    // 数组中只有一个数字
    func testCase6()
    {
        let nums = [2]
        XCTAssertEqual(solution.minArray(nums), 2)
    }
}

UnitTests.defaultTestSuite.run()
