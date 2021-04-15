import Foundation
import XCTest

class Solution
{
    /**
     获取圆圈中最后剩下的数字
     解法：环形链表
     - Parameters:
        - n:表示圆圈中的数字为0...n-1
        - m:表示每次删除第m个数字
     - Returns: 最后一个数字
     */
    func lastNumberInCircle_Solution1(n: Int, m: Int) -> Int?
    {
        // 边界处理
        guard n > 0 && m > 0 else { return nil }
            
        // 用数组来模拟圆圈中的数字
        var circleArray = [Int]()
        for i in 0..<n
        {
            circleArray.append(i)
        }
        
        // 通过这个下标来寻找待删除的位置，下标最初位于圆圈的起始位置
        var currentDeleteIndex = circleArray.startIndex
        
        // 每次删除圆圈中的第m个数字，直到只剩下一个数字
        while circleArray.count > 1
        {
            // 从圆圈中走m步，用下标记录下走到的位置
            for _ in 1 ..< m
            {
                currentDeleteIndex += 1
                
                // 防止走m步后造成数组越界需要重置走到的位置为圆圈的开始位置（endIndex和数组的元素数量相等）
                if currentDeleteIndex >= circleArray.endIndex
                {
                    currentDeleteIndex = circleArray.startIndex
                }
            }
            
            // 走到需要删除的数字位置时执行杀死操作
            circleArray.remove(at: currentDeleteIndex)
            
            // 防止将数组移除后由于endIndex减少了一个导致currentDeleteIndex越界
            if currentDeleteIndex >= circleArray.endIndex
            {
                currentDeleteIndex = circleArray.startIndex
            }
        }
        
        // 圆圈中最后只剩下一个数字
        return circleArray.first
    }
    
    /**
     获取圆圈中最后剩下的数字
     解法：数学公式
     - Parameters:
        - n:表示圆圈中的数字为0...n-1
        - m:表示每次删除第m个数字
     - Returns: 最后一个数字
     */
    func lastNumberInCircle_Solution2(n: Int, m: Int) -> Int?
    {
        // 边界处理
        guard n > 0 && m > 0 else { return nil }
        
        // 记录最后一个数字
        var lastNumber = 0
        
        // n为1的时候，lastNumber为0，不需要单独列出来
        for i in 2...n
        {
            // (上一次的结果 + m) % i
            lastNumber = (lastNumber + m) % i
        }
        
        return lastNumber
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
        XCTAssertEqual(3, solution.lastNumberInCircle_Solution1(n: 5, m: 3))
        XCTAssertEqual(3, solution.lastNumberInCircle_Solution2(n: 5, m: 3))
    }
    
    func testCase2()
    {
        XCTAssertEqual(2, solution.lastNumberInCircle_Solution1(n: 5, m: 2))
        XCTAssertEqual(2, solution.lastNumberInCircle_Solution2(n: 5, m: 2))
    }

    func testCase3()
    {
        XCTAssertEqual(4, solution.lastNumberInCircle_Solution1(n: 6, m: 7))
        XCTAssertEqual(4, solution.lastNumberInCircle_Solution2(n: 6, m: 7))
    }

    func testCase4()
    {
        XCTAssertEqual(3, solution.lastNumberInCircle_Solution1(n: 6, m: 6))
        XCTAssertEqual(3, solution.lastNumberInCircle_Solution2(n: 6, m: 6))
    }

    func testCase5()
    {
        XCTAssertEqual(nil, solution.lastNumberInCircle_Solution1(n: 0, m: 0))
        XCTAssertEqual(nil, solution.lastNumberInCircle_Solution2(n: 0, m: 0))
    }

    func testCase6()
    {
        //XCTAssertEqual(1027, solution.lastNumberInCircle_Solution1(n: 4000, m: 997))
        XCTAssertEqual(1027, solution.lastNumberInCircle_Solution2(n: 4000, m: 997))
    }
}

UnitTests.defaultTestSuite.run()
