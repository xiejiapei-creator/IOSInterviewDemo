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
     合并两个排序链表，并仍旧有序
     - Parameters:
        - node1: 链表1的头结点
        - node2: 链表2的头结点
     - Returns: 合并后的链表头节点
     */
    func mergeList(_ node1: ListNode?, _ node2: ListNode?) -> ListNode?
    {
        // 两个链表的一个或者两个头节点为空
        if node1 == nil
        {
            return node2
        }
        else if node2 == nil
        {
            return node1
        }
        
        var mergeListNode: ListNode? = nil
        if node1!.value < node2!.value
        {
            mergeListNode = node1
            mergeListNode!.next = mergeList(node1!.next, node2)
        }
        else
        {
            mergeListNode = node2
            mergeListNode!.next = mergeList(node1, node2!.next)
        }
        
        return mergeListNode
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
        // list1: 1->3->5
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node3
        node3.next = node5
        
        // list2: 2->4->6
        let node2:ListNode = ListNode(value: 2, next: nil)
        let node4:ListNode = ListNode(value: 4, next: nil)
        let node6:ListNode = ListNode(value: 6, next: nil)
        node2.next = node4
        node4.next = node6
        
        let head = solution.mergeList(node1, node2)
        XCTAssertEqual(head?.value, 1)
        XCTAssertEqual(head?.next?.value, 2)
        XCTAssertEqual(head?.next?.next?.value, 3)
        XCTAssertEqual(head?.next?.next?.next?.value, 4)
        XCTAssertEqual(head?.next?.next?.next?.next?.value, 5)
        XCTAssertEqual(head?.next?.next?.next?.next?.next?.value, 6)
    }
    
    func testCase2()
    {
        // list1: 1->3->5
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node3
        node3.next = node5
        
        // list2: 1->3->5
        let node2:ListNode = ListNode(value: 1, next: nil)
        let node4:ListNode = ListNode(value: 3, next: nil)
        let node6:ListNode = ListNode(value: 5, next: nil)
        node2.next = node4
        node4.next = node6
        
        let head = solution.mergeList(node1, node2)
        XCTAssertEqual(head?.value, 1)
        XCTAssertEqual(head?.next?.value, 1)
        XCTAssertEqual(head?.next?.next?.value, 3)
        XCTAssertEqual(head?.next?.next?.next?.value, 3)
        XCTAssertEqual(head?.next?.next?.next?.next?.value, 5)
        XCTAssertEqual(head?.next?.next?.next?.next?.next?.value, 5)
    }
    
    func testCase3()
    {
        // list1: 1
        let node1:ListNode = ListNode(value: 1, next: nil)
        // list2: 2
        let node2:ListNode = ListNode(value: 2, next: nil)
        
        let head = solution.mergeList(node1, node2)
        XCTAssertEqual(head?.value, 1)
        XCTAssertEqual(head?.next?.value, 2)
    }
    
    func testCase4()
    {
        // list1: 1->3->5
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node3
        node3.next = node5
        
        // list2: nil
        let head = solution.mergeList(node1, nil)
        XCTAssertEqual(head?.value, 1)
        XCTAssertEqual(head?.next?.value, 3)
        XCTAssertEqual(head?.next?.next?.value, 5)
    }

    func testCase5()
    {
        // list1、list2: nil
        let head = solution.mergeList(nil, nil)
        XCTAssertNil(head)
    }
}

UnitTests.defaultTestSuite.run()
