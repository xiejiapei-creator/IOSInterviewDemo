import Foundation
import XCTest

class Solution
{
    /**
     返回递增排序数组numbers中和为sum的两个数字
     - Parameters:
        - numbers: 数组
        - sum: 和
     - Returns: 和为sum的两个数字
     */
    func findNumbersWithSum(_ array: [Int], _ sum: Int) -> (number1: Int?, number2: Int?)
    {
        guard array.count >= 2  else { return (nil, nil) }
            
        // 创建两个指针，分别指向排序数组的开头和结尾
        var startIndex = 0
        var endIndex = array.count - 1
        
        // 不能相等，因为我们需要指针指向两个数字
        while startIndex < endIndex
        {
            // 计算指针指向的两个数字之和
            let currentSum = array[startIndex] + array[endIndex]
            
            // 倘若和与我们期待的结果相等，即找到了这两个数字
            if currentSum == sum
            {
                return (array[startIndex], array[endIndex])
            }
            // 如果和小于期待值则选择较小的数字后面的数字进行下一轮
            else if currentSum < sum
            {
                startIndex += 1
            }
            // 如果和大于期待值则选择较大的数字前面的数字进行下一轮
            else
            {
                endIndex -= 1
            }
        }
        
        return (nil, nil)
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
    
    // 存在和为s的两个数字，这两个数字位于数组的中间
    func testCase1()
    {
        let numbers = [1,2,4,7,11,16]
        let result = solution.findNumbersWithSum(numbers, 15)
        
        XCTAssertEqual(4, result.number1)
        XCTAssertEqual(11, result.number2)
    }

    // 存在和为s的两个数字，这两个数字位于数组的两段
    func testCase2()
    {
        let numbers = [1,2,4,7,11,16]
        let result = solution.findNumbersWithSum(numbers, 17)

        XCTAssertEqual(1, result.number1)
        XCTAssertEqual(16, result.number2)
    }
    
    // 不存在和为s的两个数字
    func testCase3()
    {
        let numbers = [1,2,4,7,11,16]
        let result = solution.findNumbersWithSum(numbers, 10)

        XCTAssertEqual(nil, result.number1)
        XCTAssertEqual(nil, result.number2)
    }
}

UnitTests.defaultTestSuite.run()
