import Foundation
import XCTest

class Solution
{
    /**
     计算机器人在m行n列方格中可到达的格子数量
     - Parameters:
        - rows: 方格行数
        - columns: 方格列数
        - k: 行坐标和列坐标的数位之和限制
     - Returns: 返回能够到达格子数
     */
    func movingCount(rows: Int, columns: Int, k: Int) -> Int
    {
        // 用来记录方格访问记录的矩阵
        var visited = Array(repeating: Array(repeating: false, count: columns), count: rows)
        return movingCountCore(rows: 0, columns: 0, k: k, visited: &visited)
    }
    
    // 核心实现
    private func movingCountCore(rows: Int, columns: Int, k: Int, visited: inout [[Bool]]) -> Int
    {
        // 当它准备进入坐标为(i,j)的格子时，通过检查坐标的数位和来判断机器人是否能够进入
        var result = 0
        if columns >= 0 && rows >= 0 &&
            rows < visited.count && columns < visited[0].count &&
            sumOfDigts(rows) + sumOfDigts(columns) <= k &&
            !visited[rows][columns]
        {
            visited[rows][columns] = true
            
            // 如果机器人能够进入坐标为(i,j)的格子，则再判断它能否进入4个相邻的格子(i,j-1)、(i-1,j)、 (i,j+1) 和(i+1,j)
            result = 1 + movingCountCore(rows: rows + 1, columns: columns, k: k, visited: &visited) +  movingCountCore(rows: rows, columns: columns + 1, k: k, visited: &visited) +  movingCountCore(rows: rows - 1, columns: columns, k: k, visited: &visited) +  movingCountCore(rows: rows, columns: columns - 1, k: k, visited: &visited)
        }
        return result
    }
    
    // 计算数字之和
    func sumOfDigts(_ num: Int) -> Int
    {
        var num = num
        var sum = 0
        while num != 0
        {
            sum += (num % 10)
            num = num / 10
        }
        return sum
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
    
    // 10行10列 k为5
    func testCase1()
    {
        XCTAssertEqual(solution.movingCount(rows: 10, columns: 10, k: 5), 21)
    }
    
    // 20行20列 k为15
    func testCase2()
    {
        XCTAssertEqual(solution.movingCount(rows: 20, columns: 20, k: 15), 359)
    }
    
    // 1行100列 k为10
    func testCase3()
    {
        XCTAssertEqual(solution.movingCount(rows: 1, columns: 100, k: 10), 29)
    }
    
    // 1行10列 k为10
    func testCase4()
    {
        XCTAssertEqual(solution.movingCount(rows: 1, columns: 10, k: 10), 10)
    }
    
    // 100行1列 k为15
    func testCase5()
    {
        XCTAssertEqual(solution.movingCount(rows: 100, columns: 1, k: 15), 79)
    }
    
    // 10行1列 k为15
    func testCase6()
    {
        XCTAssertEqual(solution.movingCount(rows: 10, columns: 1, k: 15), 10)
    }
    
    // 1行1列 k为15
    func testCase7()
    {
        XCTAssertEqual(solution.movingCount(rows: 1, columns: 1, k: 15), 1)
    }
    
    // 1行1列 k为1
    func testCase8()
    {
        XCTAssertEqual(solution.movingCount(rows: 1, columns: 1, k: 1), 1)
    }
    
    // 10行10列 k为负数
    func testCase9()
    {
        XCTAssertEqual(solution.movingCount(rows: 10, columns: 10, k: -1), 0)
    }
}

UnitTests.defaultTestSuite.run()

