import Foundation
import XCTest

class Queue
{
    // 使用array模拟stack，只用了数组的append和popLast方法
    var stack1 = [Int]()
    var stack2 = [Int]()
    
    /**
     在队列末端添加元素
     - Parameters:
        - element: 待添加的元素
     */
    func appendTail(_ value: Int)
    {
        stack1.append(value)
    }
    
    /**
     删除头节点
     - Returns: 被删除的头节点
     */
    func deleteHead() -> Int
    {
        // 若队列中没有元素，deleteHead 操作返回 -1
        if stack2.isEmpty
        {
            while let popValue = stack1.popLast()
            {
                stack2.append(popValue)
            }
            return stack2.popLast()!
        }
        
        return stack2.popLast() ?? -1
    }
}

class UnitTests: XCTestCase
{
    var queue: Queue!
    
    override func setUp()
    {
        super.setUp()
        
        queue = Queue()
    }
    
    func testCase()
    {
        queue.appendTail(1)
        queue.appendTail(2)
        queue.appendTail(3)
        XCTAssertEqual(1, queue.deleteHead())
        XCTAssertEqual(2, queue.deleteHead())
    
        queue.appendTail(4)
        XCTAssertEqual(3, queue.deleteHead())
        
        queue.appendTail(5)
        XCTAssertEqual(4, queue.deleteHead())
        
        XCTAssertEqual(5, queue.deleteHead())
    }
}

UnitTests.defaultTestSuite.run()
