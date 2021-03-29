import Foundation
import XCTest

class Solution
{
    /**
     判断在一个矩阵中是否存在一条包含某字符串所有字符的路径
     - Parameters:
        - matrix: 字符矩阵
        - path: 需要查找的字符串
     - Returns: 是否存在
     */
    func findPath(_ matrix: [[Character]], path: String) -> Bool
    {
        // 需要定义和字符矩阵大小一样的布尔值矩阵，用来标识路径是否已经进入了每个格子
        var visited = Array(repeating: Array(repeating: false, count: matrix[0].count), count: matrix.count)

        var pathIndex = 0// 路径字符串中下标
        for row in 0 ..< matrix.count// 每行
        {
            for column in 0 ..< matrix[0].count// 每列
            {
                if findPathCore(matrix: matrix, path: path, row: row, column: column, pathIndex: &pathIndex, visited: &visited)
                {
                    return true// 找到路径
                }
            }
        }
        return false// 未找到路径
    }
    
    /**
     查找matrix的第row行和第column列的字符是否和path的第pathIndex个字符相同
     并判断矩阵相邻的字符串是否与pathIndex下一个字符相同
     - Parameters:
        - matrix: 字符矩阵
        - row: 矩阵第row行
        - column: 矩阵第column列
        - path: 查找的字符串
        - pathIndex: 当前查找的第pathIndex个字符
        - visited：记录是否已经对比过
     - Returns: 是否相同
     */
    func findPathCore(matrix: [[Character]], path: String, row: Int, column: Int, pathIndex: inout Int, visited: inout [[Bool]]) -> Bool
    {
        if pathIndex >= path.count
        {
            return true
        }

        // matrix的第row行和第column列的字符是否和path的第pathIndex个字符相同
        var result = false// 返回判断结果
        // 注意这里有个大坑：千万不要为了美观简洁将以下判断条件抽离出来划分为各组然后将各组的判断结果进行合并来进行最后的判断
        // 因为判断条件之间会产生冲突，导致方法出错，我找了好久才发现问题所在😂
        if (row >= 0 && row < matrix.count && column >= 0 && column < matrix[0].count &&  matrix[row][column] == path[path.index(path.startIndex, offsetBy: pathIndex)] && !visited[row][column])
        {
            // 当前字符已经被访问过
            visited[row][column] = true

            // 回溯法经常使用递归调用：判断矩阵相邻的字符串是否与pathIndex下一个字符相同
            pathIndex += 1

            result = findPathCore(matrix: matrix, path: path, row: row, column: column - 1, pathIndex: &pathIndex, visited: &visited) || findPathCore(matrix: matrix, path: path, row: row - 1, column: column, pathIndex: &pathIndex, visited: &visited) ||
                findPathCore(matrix: matrix, path: path, row: row, column: column + 1, pathIndex: &pathIndex, visited: &visited) || findPathCore(matrix: matrix, path: path, row: row + 1, column: column, pathIndex: &pathIndex, visited: &visited)

            // 如果4个相邻的格子都没有匹配字符串中下标为pathLength+1的字符
            // 则表明当前路径字符串中下标为pathLength的字符在矩阵中的定位不正确
            // 我们需要回到前一个字符(pathLength-1)，然后重新定位
            if !result
            {
                pathIndex -= 1
                visited[row][column] = false
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
        let matrix: [[Character]] = [["A","B","T","G"],["C","F","C","S"],["J","D","E","H"]]
        let path = "BFCE"
        XCTAssertTrue(solution.findPath(matrix, path: path))
    }
    
    func testCase2()
    {
        let matrix: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
        let path = "SEE"
        XCTAssertTrue(solution.findPath(matrix, path: path))
    }

    func testCase3()
    {
        let matrix: [[Character]] = [["A","B","T","G"],["C","F","C","S"],["J","D","E","H"]]
        let path = "ABFB"
        XCTAssertFalse(solution.findPath(matrix, path: path))
    }

    func testCase4()
    {
        let matrix: [[Character]] = [["A","B","C","E","H","J","I","G"],
                                     ["S","F","C","S","L","O","P","Q"],
                                     ["A","D","E","E","M","N","O","E"],
                                     ["A","D","I","D","E","J","F","M"],
                                     ["V","C","E","I","F","G","G","S"]]
        let path = "SLHECCEIDEJFGGFIE"
        XCTAssertTrue(solution.findPath(matrix, path: path))
    }


    func testCase5()
    {
        let matrix: [[Character]] = [["A","B","C","E","H","J","I","G"],
                                     ["S","F","C","S","L","O","P","Q"],
                                     ["A","D","E","E","M","N","O","E"],
                                     ["A","D","I","D","E","J","F","M"],
                                     ["V","C","E","I","F","G","G","S"]]
        let path = "SGGFIECVAASABCEHJIGQEM"
        XCTAssertTrue(solution.findPath(matrix, path: path))
    }

    func testCase6()
    {
        let matrix: [[Character]] = [["A","B","C","E","H","J","I","G"],
                                     ["S","F","C","S","L","O","P","Q"],
                                     ["A","D","E","E","M","N","O","E"],
                                     ["A","D","I","D","E","J","F","M"],
                                     ["V","C","E","I","F","G","G","S"]]
        let path = "SGGFIECVAASABCEEJIGOEM"
        XCTAssertFalse(solution.findPath(matrix, path: path))
    }


    func testCase7()
    {
        let matrix: [[Character]] = [["A","B","C","E","H","J","I","G"],
                                     ["S","F","C","S","L","O","P","Q"],
                                     ["A","D","E","E","M","N","O","E"],
                                     ["A","D","I","D","E","J","F","M"],
                                     ["V","C","E","I","F","G","G","S"]]
        let path = "SGGFIECVAASABCEHJIGQEMS"
        XCTAssertFalse(solution.findPath(matrix, path: path))
    }

    func testCase8()
    {
        let matrix: [[Character]] = [["A","A","A","A"],["A","A","A","A"],["A","A","A","A"]]
        let path = "AAAAAAAAAAAA" //12
        XCTAssertTrue(solution.findPath(matrix, path: path))
    }

    func testCase9()
    {
        let matrix: [[Character]] = [["A"]]
        let path = "A"
        XCTAssertTrue(solution.findPath(matrix, path: path))
    }

    func testCase10()
    {
        let matrix: [[Character]] = [["A"]]
        let path = "B"
        XCTAssertFalse(solution.findPath(matrix, path: path))
    }
}

UnitTests.defaultTestSuite.run()
