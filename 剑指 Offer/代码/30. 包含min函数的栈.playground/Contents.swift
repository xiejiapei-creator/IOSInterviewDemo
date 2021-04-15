import Foundation
import XCTest

struct StackWithMin<T: Comparable>
{
    // 数据栈
    private var dataArray = Array<T>()
    // 辅助栈：存放数据栈历次push元素后的最小元素，数据栈pop之后同样也pop该栈的元素
    private var minArray = Array<T>()
    
    /**
     元素入栈
     - Parameters:
        - value: 入栈的元素
     */
    mutating func push(_ value: T)
    {
        dataArray.append(value)
        
        if minArray.count == 0 || value < minArray.last!
        {
            // 当新元素比之前的最小元素小时，把新元素插入辅助栈里
            minArray.append(value)
        }
        else
        {
            // 否则把之前的最小元素重复插入辅助栈里
            minArray.append(minArray.last!)
        }
    }
    
    /**
     元素出栈
     - returns: 出栈的元素
     */
    mutating func pop() -> T?
    {
        if dataArray.count > 0 && minArray.count > 0
        {
            // 同时需要弹出辅助栈的栈顶元素
            minArray.removeLast()
            return dataArray.removeLast()
        }
        
        return nil
    }
    
    /**
     返回栈中的最小值
     - returns: 栈中最小元素
     */
    func min() -> T?
    {
        return minArray.last
    }
    
    /**
     返回栈顶元素
     - returns: 栈顶元素
     */
    func top() -> T?
    {
        return dataArray.last
    }
    
    /**
     判断栈是否为空
     - returns: 栈是否为空
     */
    func isEmptyStack() -> Bool
    {
        return dataArray.isEmpty
    }
    
    /**
     返回栈的大小
     - returns: 栈的大小
     */
    func size() -> Int
    {
        return dataArray.count
    }
}

class UnitTests: XCTestCase
{
    override func setUp()
    {
        super.setUp()
    }

    func testCase1()
    {
        var stack = StackWithMin<Int>()
        stack.push(3)
        XCTAssertEqual(stack.min(), 3)
        stack.push(4)
        XCTAssertEqual(stack.min(), 3)
        stack.push(2)
        XCTAssertEqual(stack.min(), 2)
        stack.push(3)
        XCTAssertEqual(stack.min(), 2)
        stack.pop()
        XCTAssertEqual(stack.min(), 2)
        stack.pop()
        XCTAssertEqual(stack.min(), 3)
        stack.pop()
        XCTAssertEqual(stack.min(), 3)
        stack.push(0)
        XCTAssertEqual(stack.min(), 0)
    }
}

UnitTests.defaultTestSuite.run()

