import Foundation
import XCTest

class Solution
{
    /**
     打印（返回）矩阵顺时针序列
     - Parameters:
        - numbers: 矩阵（二维数组）
     - Returns: 顺时针序列（可能不存在）
     */
    func printMatrixClockwise(_ matrix: [[Int]]) -> [Int]?
    {
        // 行数和列数都需要大于0
        guard matrix.count > 0 && matrix[0].count > 0 else
        {
            return nil
        }
        
        // 在矩阵中选取左上角为(start, start)的一圈作为我们分析的目标，打印第一圈的左上角的坐标是(0, 0)
        var start = 0
        
        // 存储所有圈的顺时针序列
        var result = [Int]()
        
        // 让循环继续的条件是columns > startX x 2并且rows > startY x 2
        while matrix.count > start * 2 && matrix[0].count > start * 2
        {
            // 传入矩阵的轮数
            result.append(contentsOf: printMatrixClockwiseCore(matrix, start: start))
            start += 1
        }
        
        return result
    }
    
    /**
     返回矩阵每一圈的顺时针序列
     - Parameters:
        - numbers: 矩阵（二维数组）
        - start: 矩阵的轮数
     - Returns: 顺时针序列
     */
    private func printMatrixClockwiseCore(_ matrix:[[Int]], start: Int) -> [Int]
    {
        // 每一圈中行结束的位置
        let endX = matrix[start].count - 1 - start
        // 每一圈中列结束的位置
        let endY = matrix.count - 1 - start
        
        // 存储每一圈的顺时针序列
        var result = [Int]()
        
        // 从左到右打印一行
        for i in stride(from: start, through: endX, by: 1)
        {
            result.append(matrix[start][i])
        }
        
        // 从上到下打印一列。需要第二步的前提条件是终止行号大于起始行号
        if start < endY
        {
            for i in stride(from: start + 1, through: endY, by: 1)
            {
                result.append(matrix[i][endX])
            }
        }
        
        // 从右到左打印一行
        // 需要第三步打印的前提条件是圈内至少有两行两列，也就是说，除了要求终止行号大于起始行号，还要求终止列号大于起始列号
        if start < endX && start < endY
        {
            for i in stride(from: endX - 1, through: start, by: -1)
            {
                result.append(matrix[endY][i])
            }
        }
        
        // 从下到上打印一列
        // 需要打印第四步的前提条件是至少有三行两列，因此要求终止行号比起始行号至少大2，同时终止列号大于起始列号
        if start < endX && start < endY - 1
        {
            for i in stride(from: endY - 1, through: start + 1, by: -1)
            {
                result.append(matrix[i][start])
            }
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
        let matrix:[[Int]] = [[1]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) == [1])
    }
    
    func testCase2()
    {
        let matrix:[[Int]] = [[1,2],[3,4]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) == [1,2,4,3])
    }

    func testCase3()
    {
        let matrix:[[Int]] = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) == [1,2,3,4,8,12,16,15,14,13,9,5,6,7,11,10])
    }
    
    func testCase4()
    {
        let matrix:[[Int]] = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20],[21,22,23,24,25]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) ==
            [1,2,3,4,5,10,15,20,25,24,23,22,21,16,11,6,7,8,9,14,19,18,17,12,13])
    }
    
    func testCase5()
    {
        let matrix:[[Int]] = [[1],[2],[3],[4],[5]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) == [1,2,3,4,5])
    }
    
    func testCase6()
    {
        let matrix:[[Int]] = [[1,2],[3,4],[5,6],[7,8],[9,10]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) == [1,2,4,6,8,10,9,7,5,3])
    }
    
    func testCase7()
    {
        let matrix:[[Int]] = [[1,2,3],[4,5,6],[7,8,9],[10,11,12],[13,14,15]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) == [1,2,3,6,9,12,15,14,13,10,7,4,5,8,11])
    }
    
    func testCase8()
    {
        let matrix:[[Int]] = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16],[17,18,19,20]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) == [1,2,3,4,8,12,16,20,19,18,17,13,9,5,6,7,11,15,14,10])
    }

    func testCase9()
    {
        let matrix:[[Int]] = [[1,2,3,4,5]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) == [1,2,3,4,5])
    }
    
    func testCase10()
    {
        let matrix:[[Int]] = [[1,2,3,4,5],[6,7,8,9,10]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) == [1,2,3,4,5,10,9,8,7,6])
    }
    
    func testCase11()
    {
        let matrix:[[Int]] = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) == [1,2,3,4,5,10,15,14,13,12,11,6,7,8,9])
    }

    func testCase12()
    {
        let matrix:[[Int]] = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20]]
        XCTAssertTrue(solution.printMatrixClockwise(matrix) == [1,2,3,4,5,10,15,20,19,18,17,16,11,6,7,8,9,14,13,12])
    }
}

UnitTests.defaultTestSuite.run()








