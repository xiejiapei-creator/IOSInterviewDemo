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
     如果链表中存在环，则返回环的入口节点
     - Parameters:
        - head: 链表的头节点
     - Returns: 返回环的入口节点
     */
    func entryNodeOfLoop(_ head: ListNode?) -> ListNode?
    {
        // 查找快慢指针相遇的节点
        let meetNode = meetingNode(head)
        if meetNode == nil
        {
            return nil
        }

        // 计算环中的节点数量
        var tempNode = head!
        var nodesOfLoop = 1
        while tempNode.next !== meetNode
        {
            tempNode = tempNode.next!
            nodesOfLoop += 1
        }
        
        // 先移动pNode1，次数为环中节点的数目
        var pNode1 = head!
        for _ in 1...nodesOfLoop
        {
            pNode1 = pNode1.next!
        }
        
        // 然后两个指针以相同的速度向前移动
        // 当第二个指针指向环的入口节点时，第一个指针已经围绕着环走了一圈，又回到了入口节点
        var pNode2 = head!
        while pNode1 !== pNode2
        {
            pNode2 = pNode2.next!
            pNode1 = pNode1.next!
        }
        
        return pNode1
    }
    
    /**
     查找快慢指针相遇的节点
     定义两个指针：一个慢指针（一次走一步）一个快指针（一次走两步）
     如果快指针追上了慢指针，则链表包含环
     - Parameters:
        - head: 链表的头节点
     - Returns: 返回环中的某个节点，如果为空，则说明不存在环
     */
    func meetingNode(_ head: ListNode?) -> ListNode?
    {
        if head == nil
        {
            return nil
        }
        
        // 创建一个慢指针（一次走一步）
        var slowNode = head!.next
        
        // 只有一个节点，没有环
        if slowNode == nil
        {
            return nil
        }
        
        // 创建一个快指针（一次走两步）
        var fastNode = slowNode!.next
        while fastNode != nil && slowNode != nil
        {
            // 如果快指针追上了慢指针，则链表包含环
            if fastNode === slowNode
            {
                return slowNode
            }
            
            slowNode = slowNode!.next
            fastNode = fastNode!.next
            if fastNode?.next != nil
            {
                fastNode = fastNode?.next
            }
        }
        return nil
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
    
    // 只有一个节点，没有环
    func testCase1()
    {
        let node1:ListNode = ListNode(value: 1, next: nil)
        XCTAssertNil(solution.entryNodeOfLoop(node1))
    }
    
    // 只有一个节点，存在环
    func testCase2()
    {
        let node1:ListNode = ListNode(value: 1, next: nil)
        node1.next = node1
        
        XCTAssertEqual(solution.entryNodeOfLoop(node1)?.value, 1)
    }
    
    // 多个节点，存在环，入口节点在3
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
        node5.next = node3
        
        XCTAssertEqual(solution.entryNodeOfLoop(node1)?.value, 3)
    }
    
    // 多个节点，存在环，入口节点在1
    func testCase4()
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
        node5.next = node1
        
        XCTAssertEqual(solution.entryNodeOfLoop(node1)?.value, 1)
    }
    
    // 多个节点，存在环，入口节点在5
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
        node5.next = node5
        
        XCTAssertEqual(solution.entryNodeOfLoop(node1)?.value, 5)
    }
    
    // 多个节点，不存在环
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
        
        XCTAssertNil(solution.entryNodeOfLoop(node1))
    }
}

UnitTests.defaultTestSuite.run()
 
