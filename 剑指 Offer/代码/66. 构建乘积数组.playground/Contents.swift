import Foundation
import XCTest

class Solution1
{
    /*
     构建乘积数组
     - Parameters:
        - nums: 数组A
     - Returns: 乘积结果 数组B
     */
    func buildProductionArray(nums:[Int]) -> [Int]
    {
        guard nums.count > 0 else { return [Int]() }

        var output = Array(repeating: 0, count: nums.count)
        output[0] = 1
        for index in 1..<nums.count
        {
            output[index] = output[index-1] * nums[index-1]
        }
        var temp = 1
        for index in stride(from: nums.count-2, through: 0, by: -1)
        {
            temp *= nums[index + 1]
            output[index] *= temp
        }
        return output
    }
}

class UnitTests: XCTestCase
{
    let solution1 = Solution1()
    override func setUp()
    {
        super.setUp()
    }
    
    func testCase1()
    {
        let result = solution1.buildProductionArray(nums: [1,2,3,4,5])
        XCTAssertEqual([120,60,40,30,24], result)
    }
    
    func testCase2()
    {
        let result = solution1.buildProductionArray(nums: [1,2,0,4,5])
        XCTAssertEqual([0,0,40,0,0], result)
    }
    
    func testCase3()
    {
        let result = solution1.buildProductionArray(nums: [1,2,0,4,0])
        XCTAssertEqual([0,0,0,0,0], result)
    }
    
    func testCase4()
    {
        let result = solution1.buildProductionArray(nums: [1,-2,3,-4,5])
        XCTAssertEqual([120,-60,40,-30,24], result)
    }
    
    func testCase5()
    {
        let result = solution1.buildProductionArray(nums: [1,-2])
        XCTAssertEqual([-2,1], result)
    }
}

UnitTests.defaultTestSuite.run()

 
