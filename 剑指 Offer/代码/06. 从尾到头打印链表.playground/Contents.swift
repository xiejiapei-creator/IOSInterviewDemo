import Foundation
import XCTest

// 链表节点
class ListNode
{
    var next: ListNode?// 下个节点，可能不存在
    var value: Int// 当前节点的值
    
    init(value: Int, next: ListNode?)
    {
        self.value = value
        self.next = next
    }
}

class Solution
{
    /**
     从尾到头打印链表
     - Parameters:
        - headNode: 头结点
     - Returns: 链表从尾到头的值
     */
    func reverseListNode(_ headNode: ListNode) -> [Int]
    {
        var result = [Int]()
        var currentNode: ListNode? = headNode
        
        while currentNode != nil
        {
            result.append(currentNode!.value)
            currentNode = currentNode!.next
        }
        
        for item in result.reversed()
        {
            print("链表从尾到头的值:\(item)")
        }

        return result.reversed()
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
    
    // 输入的链表有多个节点
    func testCase1()
    {
        // 1->2->3->4->5
        let node5 = ListNode(value: 5, next: nil)
        let node4 = ListNode(value: 4, next: node5)
        let node3 = ListNode(value: 3, next: node4)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        
        XCTAssertEqual(solution.reverseListNode(node1), [5,4,3,2,1])
    }
    
    // 输入的链表只有一个节点
    func testCase2()
    {
        // 1
        let node1 = ListNode(value: 1, next: nil)
        XCTAssertEqual(solution.reverseListNode(node1), [1])
    }
}

UnitTests.defaultTestSuite.run()
