import Foundation
import XCTest

class Solution
{
    // 存储队列最大值
    private var maximums = [(value: Int , index: Int)]()
    
    // 存储队列的值
    private var data = [(value: Int, index: Int)]()
    
    // 当前位置
    private var currentIndex = 0
    
    // 获取当前队列最大值
    public func max() -> Int?
    {
        guard maximums.count > 0 else { return nil }
            
        return maximums.first!.value
    }
    
    // 入队
    public func push(_ number: Int)
    {
        // 将比number小的数字全部从最大值队列中移除
        while maximums.count > 0 && number > maximums.last!.value
        {
            maximums.removeLast()
        }

        // 将number添加到数据队列和最大值队列中
        data.append((number, currentIndex))
        maximums.append((number, currentIndex))

        currentIndex += 1
    }
    
    // 出队
    public func pop() -> Int?
    {
        guard data.count > 0 else { return nil }
        
        // 判断是否需要移除最大值队列中的元素
        if maximums.first!.index == data.first!.index
        {
            maximums.removeFirst()
        }
            
        // 移除数据队列中的首个元素
        return data.removeFirst().value
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
        // [2]
        solution.push(2)
        XCTAssertEqual(2, solution.max())
        
        // [2,3]
        solution.push(3)
        XCTAssertEqual(3, solution.max())

        // [2,3,4]
        solution.push(4)
        XCTAssertEqual(4, solution.max())

        // [2,3,4,2]
        solution.push(2)
        XCTAssertEqual(4, solution.max())

        // [3,4,2]
        solution.pop()
        XCTAssertEqual(4, solution.max())

        // [4,2]
        solution.pop()
        XCTAssertEqual(4, solution.max())

        // [2]
        solution.pop()
        XCTAssertEqual(2, solution.max())

        // [2,6]
        solution.push(6)
        XCTAssertEqual(6, solution.max())

        // [2,6,2]
        solution.push(2)
        XCTAssertEqual(6, solution.max())

        // [2,6,2,5]
        solution.push(5)
        XCTAssertEqual(6, solution.max())

        // [6,2,5]
        solution.pop()
        XCTAssertEqual(6, solution.max())

        // [2,5]
        solution.pop()
        XCTAssertEqual(5, solution.max())

        // [5]
        solution.pop()
        XCTAssertEqual(5, solution.max())

        // [5,1]
        solution.push(1)
        XCTAssertEqual(5, solution.max())
        
    }
}

UnitTests.defaultTestSuite.run()
