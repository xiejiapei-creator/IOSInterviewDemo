import Foundation
import XCTest

class Solution
{
    /**
     求礼物的最大价值
     解法：遍历矩阵每个位置，计算当前位置最大礼物价值，根据移动特性，它由当前位置的左和上的两个元素的决定
     - Parameters:
        - giftMatrix: 礼物的矩阵
     - Returns: 礼物的最大价值
     */
    func getGiftMaxValue_solution1(_ giftMatrix: [[Int]]) -> Int
    {
        // 边界值处理
        if giftMatrix.count == 0 { return 0 }
            
        // 存储中间结果的二维矩阵，防止递归造成的重复计算
        var maxValueArray = [[Int]]()
        
        // 遍历礼物矩阵，获得每一行的位置和数组值
        for (i, giftArray) in giftMatrix.enumerated()
        {
            // 初始化新行：从[]转变为[[]]，再转变为[[1, 3, 6], []]，接着[[1, 3, 6], [5, 10, 16], []]
            maxValueArray.append([Int]())
            
            // 遍历每一行的礼物数组，获取每个礼物的列位置和价值
            for (j, giftValue) in giftArray.enumerated()
            {
                // 每次在后面拼接0作为初始值：从[[]]转变为[[0]]，再转变为[[1, 0]]，接着[[1, 3, 0]]...
                maxValueArray[i].append(0)
                
                // 我们有两种可能的途径到达坐标为(i,j)的格子：通过格子(i-1,j)或者(i,j-1)，即当前格子的上面那个格子或者左边那个格子
                var left = 0
                var up = 0
                if i > 0
                {
                    // 获取当前格子的上面那个格子的最大值
                    up = maxValueArray[i - 1][j]
                }
                
                if j > 0
                {
                    // 获取当前格子的左面那个格子的最大值
                    left = maxValueArray[i][j-1]
                }
                
                // 将行、列上的最大值进行比较，再将最大值与本格礼物值相加得到最终结果
                // f(i,j)= max(f(i-1,j)，f(i,j-1)) + gift[i,j]
                // 从[[0]]转变为[[1]]，再转变为[[1, 3]]...
                maxValueArray[i][j] = max(left, up) + giftValue
            }
        }
        
        // 最后一个元素就是礼物的最大价值
        return maxValueArray.last!.last!
    }
    
    /**
     求礼物的最大价值
     与解法1的区别是中间结果只需要一维数组即可
     - Parameters:
        - giftMatrix: 礼物的矩阵
     - Returns: 礼物最大值
     */
    func getGiftMaxValue_solution2(_ giftMatrix: [[Int]]) -> Int
    {
        if giftMatrix.count == 0 { return 0 }
        
        // 与解法1的区别是中间结果只需要一维数组即可
        var maxValueArray = [Int]()
        
        for (i, giftArray) in giftMatrix.enumerated()
        {
            for (j, giftValue) in giftArray.enumerated()
            {
                // 首行每次拼接0作为初始值：从[]转变为[0]，再转变为[1, 0]，接着[1, 3, 0]...
                if i == 0 { maxValueArray.append(0) }

                var left = 0
                var up = 0
                if i > 0
                {
                    // 获取当前格子的上面那个格子的最大值
                    up = maxValueArray[j]
                }
                
                if j > 0
                {
                    // 获取当前格子的左面那个格子的最大值
                    left = maxValueArray[j-1]
                }
                
                // 将行、列上的最大值进行比较，再将最大值与本格礼物值相加得到最终结果
                // 从[1]转变为[1, 3]，接着[1, 3, 6]，[5, 3, 6]，[5, 10, 6]，[5, 10, 16]...
                maxValueArray[j] = max(left, up) + giftValue
            }
        }
        
        // 当矩阵未满如[[1, 2, 3], [4, 5, 6], [7, 8]]时，礼物最大值不一定是最后一个元素，这种解决方式存在这样的缺陷
        return maxValueArray.last!
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
        let matrix = [[1,2,3],[4,5,6],[7,8,9]]
        //XCTAssertEqual(29, solution.getGiftMaxValue_solution1(matrix))
        XCTAssertEqual(29, solution.getGiftMaxValue_solution2(matrix))
    }
    
    func testCase2()
    {
        let matrix = [[1,10,3,8],[12,2,9,6],[5,7,4,11],[3,7,16,5]]
        XCTAssertEqual(53, solution.getGiftMaxValue_solution1(matrix))
        XCTAssertEqual(53, solution.getGiftMaxValue_solution2(matrix))
    }

    func testCase3()
    {
        let matrix = [[1,10,3,8]]
        XCTAssertEqual(22, solution.getGiftMaxValue_solution1(matrix))
        XCTAssertEqual(22, solution.getGiftMaxValue_solution2(matrix))
    }

    func testCase4()
    {
        let matrix = [[1],[12],[5],[3]]
        XCTAssertEqual(21, solution.getGiftMaxValue_solution1(matrix))
        XCTAssertEqual(21, solution.getGiftMaxValue_solution2(matrix))
    }

    func testCase5()
    {
        let matrix = [[3]]
        XCTAssertEqual(3, solution.getGiftMaxValue_solution1(matrix))
        XCTAssertEqual(3, solution.getGiftMaxValue_solution2(matrix))
    }
}

UnitTests.defaultTestSuite.run()




