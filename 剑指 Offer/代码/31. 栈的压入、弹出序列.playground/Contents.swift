import Foundation
import XCTest

class Solution
{
    /**
     基于入栈序列判断出栈序列是否可能
     - Parameters:
        - pushList: 入栈序列
        - popList: 出栈序列
     - Returns: 是否为该栈的弹出序列
     */
    func isPopOrder(pushList: [Int], popList: [Int]) -> Bool
    {
        // 记录是否为该栈的弹出序列的结果
        var result = false
        
        // 入栈序列和出栈序列需要数量相等且大于0
        guard pushList.count == popList.count && pushList.count > 0 else {
            return result
        }
        
        var dataArray = [Int]()// 辅助栈（用数组替代）
        var pushCount = 0// 入栈次数
        var popCount = 0// 出栈次数
        
        while popCount < popList.count
        {
            // 如果下一个弹出的数字不在栈顶，则把压栈序列中还没有入栈的数字压入辅助栈，直到把下一个需要弹出的数字压入栈顶为止
            while dataArray.isEmpty || dataArray.last != popList[popCount]
            {
                // 如果所有数字都压入栈后仍然没有找到下一个弹出的数字，那么该序列不可能是一个弹出序列
                if pushCount == pushList.count
                {
                    break
                }
                
                dataArray.append(pushList[pushCount])
                pushCount += 1
            }
            
            if dataArray.last != popList[popCount]
            {
                break
            }
            
            // 如果下一个弹出的数字刚好是栈顶数字，那么直接弹出
            dataArray.removeLast()
            popCount += 1
        }
        
        // 全部符合则说明是该栈的弹出序列
        if dataArray.isEmpty && popCount == popList.count
        {
            result = true
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
        XCTAssertTrue(solution.isPopOrder(pushList: [1,2,3,4,5], popList: [4,5,3,2,1]))
    }
    
    func testCase2()
    {
        XCTAssertTrue(solution.isPopOrder(pushList: [1,2,3,4,5], popList: [3,5,4,2,1]))
    }
    
    func testCase3()
    {
        XCTAssertFalse(solution.isPopOrder(pushList: [1,2,3,4,5], popList: [4,3,5,1,2]))
    }
    
    func testCase4()
    {
        XCTAssertFalse(solution.isPopOrder(pushList: [1,2,3,4,5], popList: [3,5,4,1,2]))
    }
    
    func testCase5()
    {
        XCTAssertFalse(solution.isPopOrder(pushList: [1], popList: [2]))
    }
    
    func testCase6()
    {
        XCTAssertTrue(solution.isPopOrder(pushList: [1], popList: [1]))
    }
}

UnitTests.defaultTestSuite.run()
 
