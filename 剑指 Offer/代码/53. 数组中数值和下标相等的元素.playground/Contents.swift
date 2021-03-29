import Foundation
import XCTest

class Solution
{
    /**
     查找数组中数值和下标相等的元素
     解法：二分法，如果当前下标的元素值比下标大，则右边部分元素的值都比各自的下标大，继续查找左边
     - Parameters:
        - data: 递增数组
     - Returns: 数值与下标相等的元素
     */
    func getNumberSameAsIndex(data: [Int]) -> Int?
    {
        guard data.count > 0 else { return nil }
            
        var startIndex = 0
        var endIndex = data.count - 1
        
        while startIndex <= endIndex
        {
            let midIndex = (startIndex + endIndex) / 2
            
            // 该数字的值刚好也是i，那么我们就找到了一个数字和其下标相等
            if data[midIndex] == midIndex
            {
                return midIndex
            }
            // 如果第i个数字的值大于i，那么它右边的数字都大于对应的下标，我们都可以忽略
            else if data[midIndex] > midIndex
            {
                // 下一轮查找我们只需要从它左边的数字中查找即可
                endIndex = midIndex - 1
            }
            // 数字的值m小于它的下标i的情形和上面类似。它左边的所有数字的值都小于对应的下标，我们也可以忽略
            else
            {
                startIndex = midIndex + 1
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
    
    func testCase1()
    {
        let data = [-3,-1,1,3,5]
        XCTAssertEqual(3, solution.getNumberSameAsIndex(data: data))
    }
    
    func testCase2()
    {
        let data = [0,1,3,5,6]
        XCTAssertEqual(0, solution.getNumberSameAsIndex(data: data))
    }
    
    func testCase3()
    {
        let data = [-1,0,1,2,4]
        XCTAssertEqual(4, solution.getNumberSameAsIndex(data: data))
    }
    
    func testCase4()
    {
        let data = [-1,0,1,2,5]
        XCTAssertEqual(nil, solution.getNumberSameAsIndex(data: data))
    }
    
    func testCase5()
    {
        let data = [0]
        XCTAssertEqual(0, solution.getNumberSameAsIndex(data: data))
    }
    
    func testCase6()
    {
        let data = [10]
        XCTAssertEqual(nil, solution.getNumberSameAsIndex(data: data))
    }
    
    func testCase7()
    {
        let data:[Int] = []
        XCTAssertEqual(nil, solution.getNumberSameAsIndex(data: data))
    }
}

UnitTests.defaultTestSuite.run()

