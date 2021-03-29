import Foundation
import XCTest
 
class Solution
{
    /**
     判断二维数组中是否含有该整数P（从二维数组的右上角开始查找）
     - Parameters:
        - matrix: 二维数组
        - targetNum: 目标数字
     - Returns: 是否包含目标数字
     */
    func find(_ matrix: [[Int]], targetNum: Int) -> Bool
    {
        // 可以将x和y看成x轴和y轴上的坐标位置。第一次取数组中最右上角的数字
        var y = 0
        var x = matrix.count - 1
        
        while y <= matrix[0].count - 1 && x >= 0
        {
            // 如果该数字大于要查找的数字，则剔除这个数字所在的列
            if matrix[y][x] > targetNum
            {
                x -= 1
            }
            // 如果该数字小于要查找的数字，则剔除这个数字所在的行
            else if matrix[y][x] < targetNum
            {
                y += 1
            }
            // 如果该数字等于要查找的数字，则查找过程结束
            else
            {
                return true
            }
        }
        return false
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
    
    // 目标值在最大最小值之间且在数组中
    func testCase1()
    {
        let matrix: [[Int]] = [[1,2,8,9],[2,4,9,12],[4,7,10,13],[6,8,11,15]]
        XCTAssertTrue(solution.find(matrix, targetNum: 7))
    }
    
    // 目标值是最大值
    func testCase2()
    {
        let matrix: [[Int]] = [[1,2,8,9],[2,4,9,12],[4,7,10,13],[6,8,11,15]]
        XCTAssertTrue(solution.find(matrix, targetNum: 15))
    }
    
    // 目标值是最小值
    func testCase3()
    {
        let matrix: [[Int]] = [[1,2,8,9],[2,4,9,12],[4,7,10,13],[6,8,11,15]]
        XCTAssertTrue(solution.find(matrix, targetNum: 1))
    }
    
    // 目标值位于最大值最小值之间但不在数组中
    func testCase4()
    {
        let matrix: [[Int]] = [[1,2,8,9],[2,4,9,12],[4,7,10,13],[6,8,11,15]]
        XCTAssertFalse(solution.find(matrix, targetNum: 5))
    }
    
    // 目标值大于最大值
    func testCase5()
    {
        let matrix: [[Int]] = [[1,2,8,9],[2,4,9,12],[4,7,10,13],[6,8,11,15]]
        XCTAssertFalse(solution.find(matrix, targetNum: 16))
    }
    
    // 目标值小于最小值
    func testCase6()
    {
        let matrix: [[Int]] = [[1,2,8,9],[2,4,9,12],[4,7,10,13],[6,8,11,15]]
        XCTAssertFalse(solution.find(matrix, targetNum: 0))
    }
    
    // 空数组
    func testCase7()
    {
        let matrix: [[Int]] = [[]]
        XCTAssertFalse(solution.find(matrix, targetNum: 5))
    }
}

UnitTests.defaultTestSuite.run()
