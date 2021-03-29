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
     查找链表中的倒数第K个节点
     - Parameters:
        - head: 链表的头节点
        - k: 倒数节点位置
     - Returns: 倒数第k个节点（从1开始计数，最后一个即为倒数第1个）
     */
    func findKthToTail(_ head: ListNode?, k: Int) -> ListNode?
    {
        // 空链表或者k=0
        if head == nil || k == 0
        {
            return nil
        }
        
        var pNode1 = head!
        var pNode2 = head!
        
        // 第一个指针从链表的头指针开始遍历向前走k-1步，第二个指针保持不动
        for _ in 0 ..< k-1
        {
            if pNode1.next != nil
            {
                pNode1 = pNode1.next!
            }
            // k大于节点数
            else
            {
                return nil
            }
        }
        
        // 从第k步开始，第二个指针也开始从链表的头指针开始遍历
        while pNode1.next != nil
        {
            pNode1 = pNode1.next!
            pNode2 = pNode2.next!
        }
        
        return pNode2
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
    
    // 1->2->3->4->5 倒数第2个节点值是4
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
        
        XCTAssertEqual(solution.findKthToTail(node1, k: 2)?.value, 4)
    }
    // 1->2->3->4->5 倒数第1个节点值是5
    func testCase2()
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
        
        XCTAssertEqual(solution.findKthToTail(node1, k: 1)?.value, 5)
    }
    
    // 1->2->3->4->5 倒数第5个节点值是1
    func testCase3()
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
        
        XCTAssertEqual(solution.findKthToTail(node1, k: 5)?.value, 1)
    }
    
    // 测试空链表
    func testCase4()
    {
        XCTAssertNil(solution.findKthToTail(nil, k: 5))
    }
    
    // 1->2->3->4->5 k大于节点数
    func testCase5()
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
        
        XCTAssertNil(solution.findKthToTail(node1, k: 6))
    }
    
    // 1->2->3->4->5 k=0
    func testCase6()
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
        
        XCTAssertNil(solution.findKthToTail(node1, k: 0))
    }
    
}

UnitTests.defaultTestSuite.run()





