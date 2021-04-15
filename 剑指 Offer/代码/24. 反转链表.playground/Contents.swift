import Foundation
import XCTest

// 定义链表节点
class ListNode
{
    var next: ListNode?
    var value: Int
    
    init(value: Int, next: ListNode?)
    {
        self.value = value
        self.next = next
    }
}

class Solution
{
    /**
     反转链表
     - Parameters:
        - head: 链表的头节点
     - Returns: 返回旋转之后的链表
     */
    func reverseList(_ head: ListNode?) -> ListNode?
    {
        // 我们需要定义3个指针，分别指向当前遍历到的节点、它的前一个节点及后一个节点
        var perviousNode: ListNode? = nil
        var node = head
        while node != nil
        {
            // 为了避免链表在当前节点处断开，我们需要在调整当前节点的pNext之前，把当前节点的下一个节点保存下来
            let nextNode = node!.next
            // 将当前节点指向之前存储的前一个节点
            node!.next = perviousNode
            // 移动前一个节点到当前节点
            perviousNode = node
            // 移动当前节点到下一个节点
            node = nextNode
        }
        return perviousNode
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
    
    // 多个节点
    func testCase1()
    {
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 2, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node4:ListNode = ListNode(value: 4, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        
        let head = solution.reverseList(node1)
        XCTAssertEqual(head?.value, 5)
        XCTAssertEqual(head?.next?.value, 4)
        XCTAssertEqual(head?.next?.next?.value, 3)
        XCTAssertEqual(head?.next?.next?.next?.value, 2)
        XCTAssertEqual(head?.next?.next?.next?.next?.value, 1)
    }
    
    // 1个节点
    func testCase2()
    {
        let node1:ListNode = ListNode(value: 1, next: nil)
        let head = solution.reverseList(node1)
        XCTAssertEqual(head?.value, 1)
    }
    
    // 空链表
    func testCase3()
    {
        let head = solution.reverseList(nil)
        XCTAssertNil(head)
    }
    
}

UnitTests.defaultTestSuite.run()
