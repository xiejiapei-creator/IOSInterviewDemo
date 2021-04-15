import Foundation
import XCTest

class Solution
{
    /**
     调整数组，将数组中的所有奇数位于偶数之前
     - Parameters:
        - array: 待排序的数组
     - Returns: 排序后的数组
     */
    func ReorderOddEven(array: [Int]) -> [Int]
    {
        return Reorder(array: array, criteria: { ($0 % 2) == 0 ? false : true })
    }
    
    /**
     从数组的头尾向中间遍历数组并调整（criteria）
     - Parameters:
        - array: 待调整的数组
        - criteria: 调整方法
     - Returns: 调整后的数组
     */
    func Reorder(array: [Int], criteria: (Int) -> Bool) -> [Int]
    {
        var array = array
        var startIndex = 0
        var endIndex = array.count - 1
        
        while startIndex < endIndex
        {
            while startIndex < endIndex && criteria(array[startIndex])
            {
                startIndex += 1
            }
            
            while startIndex < endIndex && !criteria(array[endIndex])
            {
                endIndex -= 1
            }
            
            if startIndex < endIndex
            {
                let tempNumber = array[endIndex]
                array[endIndex] = array[startIndex]
                array[startIndex] = tempNumber
            }
        }
        
        return array
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
        let result = solution.ReorderOddEven(array: [1,2,3,4,5,6,7])
        XCTAssertEqual(result[0], 1)
        XCTAssertEqual(result[1], 7)
        XCTAssertEqual(result[2], 3)
        XCTAssertEqual(result[3], 5)
        XCTAssertEqual(result[4], 4)
        XCTAssertEqual(result[5], 6)
        XCTAssertEqual(result[6], 2)
    }
    
    func testCase2()
    {
        let result = solution.ReorderOddEven(array: [2,4,6,1,3,5,7])
        XCTAssertEqual(result[0], 7)
        XCTAssertEqual(result[1], 5)
        XCTAssertEqual(result[2], 3)
        XCTAssertEqual(result[3], 1)
        XCTAssertEqual(result[4], 6)
        XCTAssertEqual(result[5], 4)
        XCTAssertEqual(result[6], 2)
    }
    
    func testCase3()
    {
        let result = solution.ReorderOddEven(array: [1,3,5,7,2,4,6])
        XCTAssertEqual(result[0], 1)
        XCTAssertEqual(result[1], 3)
        XCTAssertEqual(result[2], 5)
        XCTAssertEqual(result[3], 7)
        XCTAssertEqual(result[4], 2)
        XCTAssertEqual(result[5], 4)
        XCTAssertEqual(result[6], 6)
    }
    
    func testCase4()
    {
        let result = solution.ReorderOddEven(array: [1])
        XCTAssertEqual(result[0], 1)
    }
    
    func testCase5()
    {
        let result = solution.ReorderOddEven(array: [2])
        XCTAssertEqual(result[0], 2)
    }
}

UnitTests.defaultTestSuite.run()

