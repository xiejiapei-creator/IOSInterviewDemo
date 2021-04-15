import Foundation
import XCTest

// 链表节点
class ListNode
{
    var nextNode: ListNode?
    var value: Int
    
    init(value: Int, nextNode: ListNode?)
    {
        self.value = value
        self.nextNode = nextNode
    }
}

class Solution
{
    /**
     移除排序链表中重复的节点
     - Parameters:
        - head: 待删除排序链表的头节点
     - Returns: 排序链表新的头节点
     */
    func deleteDuplicateNode(_ head: ListNode) -> ListNode?
    {
        var pNode: ListNode? = head// 当前节点
        var pPreNode: ListNode? = nil// 前一个节点
        var newHead: ListNode? = head// 用来返回的新的头节点
        
        // 遍历链表
        while pNode != nil
        {
            // 记录当前节点是否需要删除
            var needDelete = false
            
            // 下一个节点存在且和当前节点值相等说明出现重复了需要删除节点
            var pNextNode = pNode!.nextNode
            if pNextNode != nil && pNode!.value == pNextNode!.value
            {
                needDelete = true
            }
            
            if !needDelete
            {
                // 如果不需要删除重复节点则继续遍历
                pPreNode = pNode
                pNode = pNode!.nextNode
            }
            else
            {
                // 需要删除重复节点则让当前节点的前一个节点指向的下一个节点为后面的第一个非重复节点
                
                let nodeValue = pNode!.value// 当前节点的值
                var toBeDeletedNode: ListNode? = pNode// 即将被删除的重复节点
                
                while toBeDeletedNode != nil && toBeDeletedNode!.value == nodeValue
                {
                    // pNextNode记录下后面的第一个非重复节点
                    pNextNode = toBeDeletedNode!.nextNode
                    toBeDeletedNode = pNextNode
                }
                
                
                if pPreNode == nil
                {
                    // 重复的节点位于链表的头部，需要将链表新头节点移动到后面的第一个非重复节点
                    newHead = pNextNode
                }
                else
                {
                    // 前一个节点指向的下一个节点为后面的第一个非重复节点
                    pPreNode!.nextNode = pNextNode
                }
                
                // 将当前节点移动到第一个非重复节点，继续向后遍历
                pNode = pNextNode
            }
        }
        return newHead
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

    // 重复的节点位于链表的中部
    func testCase1()
    {
        let node1:ListNode = ListNode(value: 1, nextNode: nil)
        let node2:ListNode = ListNode(value: 2, nextNode: nil)
        let node3:ListNode = ListNode(value: 3, nextNode: nil)
        let node4:ListNode = ListNode(value: 3, nextNode: nil)
        let node5:ListNode = ListNode(value: 4, nextNode: nil)
        let node6:ListNode = ListNode(value: 4, nextNode: nil)
        let node7:ListNode = ListNode(value: 5, nextNode: nil)
        node1.nextNode = node2
        node2.nextNode = node3
        node3.nextNode = node4
        node4.nextNode = node5
        node5.nextNode = node6
        node6.nextNode = node7
        
        // 1->2->3->3->4->4->5 删除后 1->2-5
        let newHead = solution.deleteDuplicateNode(node1)
        
        XCTAssertEqual(newHead?.value, node1.value)
        XCTAssertEqual(node1.nextNode?.value, node2.value)
        XCTAssertEqual(node2.nextNode?.value, node7.value)
        XCTAssertNil(node7.nextNode)
    }
    
    // 没有重复节点
    func testCase2()
    {
        let node1:ListNode = ListNode(value: 1, nextNode: nil)
        let node2:ListNode = ListNode(value: 2, nextNode: nil)
        let node3:ListNode = ListNode(value: 3, nextNode: nil)
        let node4:ListNode = ListNode(value: 4, nextNode: nil)
        let node5:ListNode = ListNode(value: 5, nextNode: nil)
        let node6:ListNode = ListNode(value: 6, nextNode: nil)
        let node7:ListNode = ListNode(value: 7, nextNode: nil)
        node1.nextNode = node2
        node2.nextNode = node3
        node3.nextNode = node4
        node4.nextNode = node5
        node5.nextNode = node6
        node6.nextNode = node7
        
        // 1->2->3->4->5->6->7
        let newHead = solution.deleteDuplicateNode(node1)
        
        XCTAssertEqual(newHead?.value, node1.value)
        XCTAssertEqual(node1.nextNode?.value, node2.value)
        XCTAssertEqual(node2.nextNode?.value, node3.value)
        XCTAssertEqual(node3.nextNode?.value, node4.value)
        XCTAssertEqual(node4.nextNode?.value, node5.value)
        XCTAssertEqual(node5.nextNode?.value, node6.value)
        XCTAssertEqual(node6.nextNode?.value, node7.value)
    }
    
    // 除了一个结点之外其他所有结点的值都相同
    func testCase3()
    {
        let node1:ListNode = ListNode(value: 1, nextNode: nil)
        let node2:ListNode = ListNode(value: 1, nextNode: nil)
        let node3:ListNode = ListNode(value: 1, nextNode: nil)
        let node4:ListNode = ListNode(value: 1, nextNode: nil)
        let node5:ListNode = ListNode(value: 1, nextNode: nil)
        let node6:ListNode = ListNode(value: 1, nextNode: nil)
        let node7:ListNode = ListNode(value: 2, nextNode: nil)
        node1.nextNode = node2
        node2.nextNode = node3
        node3.nextNode = node4
        node4.nextNode = node5
        node5.nextNode = node6
        node6.nextNode = node7
        
        let newHead = solution.deleteDuplicateNode(node1)
        
        XCTAssertEqual(newHead?.value, 2)
        XCTAssertNil(newHead?.nextNode)
    }
    
    // 所有结点的值都相同
    func testCase4()
    {
        let node1:ListNode = ListNode(value: 1, nextNode: nil)
        let node2:ListNode = ListNode(value: 1, nextNode: nil)
        let node3:ListNode = ListNode(value: 1, nextNode: nil)
        let node4:ListNode = ListNode(value: 1, nextNode: nil)
        let node5:ListNode = ListNode(value: 1, nextNode: nil)
        let node6:ListNode = ListNode(value: 1, nextNode: nil)
        let node7:ListNode = ListNode(value: 1, nextNode: nil)
        node1.nextNode = node2
        node2.nextNode = node3
        node3.nextNode = node4
        node4.nextNode = node5
        node5.nextNode = node6
        node6.nextNode = node7
        
        let newHead = solution.deleteDuplicateNode(node1)
        
        XCTAssertNil(newHead)
    }
    
    // 所有节点都成对出现
    func testCase5()
    {
        let node1:ListNode = ListNode(value: 1, nextNode: nil)
        let node2:ListNode = ListNode(value: 1, nextNode: nil)
        let node3:ListNode = ListNode(value: 2, nextNode: nil)
        let node4:ListNode = ListNode(value: 2, nextNode: nil)
        let node5:ListNode = ListNode(value: 3, nextNode: nil)
        let node6:ListNode = ListNode(value: 3, nextNode: nil)
        let node7:ListNode = ListNode(value: 4, nextNode: nil)
        let node8:ListNode = ListNode(value: 4, nextNode: nil)
        node1.nextNode = node2
        node2.nextNode = node3
        node3.nextNode = node4
        node4.nextNode = node5
        node5.nextNode = node6
        node6.nextNode = node7
        node7.nextNode = node8
        
        let newHead = solution.deleteDuplicateNode(node1)
        
        XCTAssertNil(newHead)
    }
    
    // 除了两个结点之外其他结点都成对出现
    func testCase6()
    {
        let node1:ListNode = ListNode(value: 1, nextNode: nil)
        let node2:ListNode = ListNode(value: 1, nextNode: nil)
        let node3:ListNode = ListNode(value: 2, nextNode: nil)
        let node4:ListNode = ListNode(value: 3, nextNode: nil)
        let node5:ListNode = ListNode(value: 3, nextNode: nil)
        let node6:ListNode = ListNode(value: 4, nextNode: nil)
        let node7:ListNode = ListNode(value: 5, nextNode: nil)
        let node8:ListNode = ListNode(value: 5, nextNode: nil)
        node1.nextNode = node2
        node2.nextNode = node3
        node3.nextNode = node4
        node4.nextNode = node5
        node5.nextNode = node6
        node6.nextNode = node7
        node7.nextNode = node8
        
        let newHead = solution.deleteDuplicateNode(node1)
        
        XCTAssertEqual(newHead!.value, 2)
        XCTAssertEqual(newHead?.nextNode?.value, 4)
        XCTAssertNil(newHead?.nextNode?.nextNode)
    }

    // 链表中只有两个不重复的结点
    func testCase7()
    {
        let node1:ListNode = ListNode(value: 1, nextNode: nil)
        let node2:ListNode = ListNode(value: 2, nextNode: nil)
        node1.nextNode = node2
        
        let newHead = solution.deleteDuplicateNode(node1)
        
        XCTAssertEqual(newHead!.value, 1)
        XCTAssertEqual(newHead?.nextNode?.value, 2)
        XCTAssertNil(newHead?.nextNode?.nextNode)
    }
    
    // 链表中只有一个结点
    func testCase8()
    {
        let node1:ListNode = ListNode(value: 1, nextNode: nil)
        
        let newHead = solution.deleteDuplicateNode(node1)
        
        XCTAssertEqual(newHead!.value, 1)
        XCTAssertNil(newHead?.nextNode)
    }
    
    // 链表中只有两个重复的结点
    func testCase9()
    {
        let node1:ListNode = ListNode(value: 1, nextNode: nil)
        let node2:ListNode = ListNode(value: 1, nextNode: nil)
        node1.nextNode = node2
        
        let newHead = solution.deleteDuplicateNode(node1)
        
        XCTAssertNil(newHead)
    }
}

UnitTests.defaultTestSuite.run()

 
