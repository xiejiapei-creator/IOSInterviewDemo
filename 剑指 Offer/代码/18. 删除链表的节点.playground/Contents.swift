import Foundation
import XCTest

// 链表节点
class ListNode
{
    var nextNode: ListNode?// 下一个节点，可能不存在
    var value: Int// 当前节点值
    
    init(value: Int, nextNode: ListNode?)
    {
        self.value = value
        self.nextNode = nextNode
    }
}

class Solution
{
    /**
     O(1)时间内删除链表的给定节点
     - Parameters:
        - headNode：头节点，可能传入nil
        - toBeDeletedNode: 需要删除的节点，可能传入nil
     */
    func deleteNode(headNode: inout ListNode?, toBeDeletedNode: ListNode?)
    {
        // 无法删除节点直接返回
        if headNode == nil || toBeDeletedNode == nil
        {
            return
        }
        
        // 链表只有1个节点，这时删除head自身
        if headNode! === toBeDeletedNode!
        {
            headNode = nil
            return
        }
        
        // 删除的节点位于尾部，需要从head开始遍历到尾节点前面的节点
        if toBeDeletedNode!.nextNode == nil
        {
            // 只是顺序查找而已，不能更改了原来的头节点，需要找个临时节点进行遍历
            var tempNode = headNode!
            // !== 用来判断引用是否相等
            while tempNode.nextNode !== toBeDeletedNode
            {
                tempNode = tempNode.nextNode!
            }
            // 删除尾节点
            tempNode.nextNode = nil
        }
        else
        {
            // 不位于尾部，只需要将toBeDeleted节点之后的节点值复制到toBeDeleted节点中，然后删除那个节点即可
            var tempNode = toBeDeletedNode!.nextNode
            toBeDeletedNode!.value = tempNode!.value
            toBeDeletedNode!.nextNode = tempNode!.nextNode
            tempNode = nil
        }
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
    
    // 从有多个节点的链表的中间删除一个节点
    func testCase1()
    {
        // 因为会将节点置为nil来表示删除，所以必须使用?
        let node5: ListNode? = ListNode(value: 5, nextNode: nil)
        let node4: ListNode? = ListNode(value: 4, nextNode: node5)
        let node3: ListNode? = ListNode(value: 3, nextNode: node4)
        let node2: ListNode? = ListNode(value: 2, nextNode: node3)
        var node1: ListNode? = ListNode(value: 1, nextNode: node2)
        
        // 1->2->3->4->5 删除3
        solution.deleteNode(headNode: &node1, toBeDeletedNode: node3)
        
        XCTAssertEqual(node1?.value, 1)
        XCTAssertEqual(node1?.nextNode?.value, 2)
        XCTAssertEqual(node1?.nextNode?.nextNode?.value, 4)
        XCTAssertEqual(node1?.nextNode?.nextNode?.nextNode?.value, 5)
    }
    
    // 从有多个节点的链表中删除尾节点
    func testCase2()
    {
        let node5:ListNode? = ListNode(value: 5, nextNode: nil)
        let node4:ListNode? = ListNode(value: 4, nextNode: node5)
        let node3:ListNode? = ListNode(value: 3, nextNode: node4)
        let node2:ListNode? = ListNode(value: 2, nextNode: node3)
        var node1:ListNode? = ListNode(value: 1, nextNode: node2)
        
        // 1->2->3->4->5 删除5
        solution.deleteNode(headNode: &node1, toBeDeletedNode: node5)
        
        XCTAssertEqual(node1!.value, 1)
        XCTAssertEqual(node1!.nextNode?.value, 2)
        XCTAssertEqual(node1!.nextNode?.nextNode?.value,3)
        XCTAssertEqual(node1!.nextNode?.nextNode?.nextNode?.value,4)
        XCTAssertNil(node1!.nextNode!.nextNode!.nextNode!.nextNode)
    }

    // 从有多个节点的链表中删除头节点
    func testCase3()
    {
        let node5:ListNode? = ListNode(value: 5, nextNode: nil)
        let node4:ListNode? = ListNode(value: 4, nextNode: node5)
        let node3:ListNode? = ListNode(value: 3, nextNode: node4)
        let node2:ListNode? = ListNode(value: 2, nextNode: node3)
        var node1:ListNode? = ListNode(value: 1, nextNode: node2)
        
        // 1->2->3->4->5 删除1
        solution.deleteNode(headNode: &node1, toBeDeletedNode: node1)
        
        XCTAssertNil(node1)
    }
    
    // 从只有一个节点的链表中删除唯一的节点
    func testCase4()
    {
        var node1:ListNode? = ListNode(value: 1, nextNode: nil)
        solution.deleteNode(headNode: &node1, toBeDeletedNode: node1)
        XCTAssertNil(node1)
    }
}
 
UnitTests.defaultTestSuite.run()

