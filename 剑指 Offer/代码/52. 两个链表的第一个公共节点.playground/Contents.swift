import Foundation
import XCTest

class ListNode: Equatable
{
    var next: ListNode?
    var value: Int
    
    init(value: Int, next: ListNode?)
    {
        self.value = value
        self.next = next
    }
    
    static func == (lhs: ListNode, rhs: ListNode) -> Bool
    {
        return lhs.value == rhs.value
    }
}

class Solution
{
    /**
     查找两个链表的第一个公共节点
     解法：分别求两链表的长度计算出长度差d，让长链表先走d个节点，然后跟短链表一起遍历每个节点，相同的那个节点便是公共节点
     - Parameters:
        - node1: 链表1
        - node2: 链表2
     - Returns: 第一个公共节点
     */
    func findFirstCommonNode(_ headNode1: ListNode?, _ headNode2: ListNode?) -> ListNode?
    {
        // 首先遍历两个链表得到它们的长度
        let list1Length = getListLength(headNode1)
        let list2Length = getListLength(headNode2)
        
        // 就能知道哪个链表比较长
        var longListHeadNode = list1Length > list2Length ? headNode1 : headNode2
        var shortListHeadNode = list1Length > list2Length ? headNode2 : headNode1
        
        // 长的链表比短的链表多几个节点
        var differentLength = abs(list1Length - list2Length)
        
        // 在第二次遍历的时候，在较长的链表上先走若干步
        while differentLength > 0 && longListHeadNode != nil
        {
            longListHeadNode = longListHeadNode!.next
            differentLength -= 1
        }
        
        // 接着同时在两个链表上遍历，找到的第一个相同的节点就是它们的第一个公共节点
        while longListHeadNode != nil && shortListHeadNode != nil && longListHeadNode != shortListHeadNode
        {
            longListHeadNode = longListHeadNode!.next
            shortListHeadNode = shortListHeadNode!.next
        }
        
        return longListHeadNode
    }
    
    // 获取链表的长度
    private func getListLength(_ headNode: ListNode?) -> Int
    {
        var headNode = headNode
        var listLength = 0
        
        while headNode != nil
        {
            listLength += 1
            headNode = headNode!.next
        }
        
        return listLength
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
    
    // 第一个公共结点在链表中间
    func testCase1()
    {
        let node7 = ListNode(value: 7, next: nil)
        let node6 = ListNode(value: 6, next: node7)
        let node5 = ListNode(value: 5, next: node6)
        let node4 = ListNode(value: 4, next: node5)
        let node3 = ListNode(value: 3, next: node6)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        XCTAssertEqual(6, solution.findFirstCommonNode(node1, node4)?.value)
    }
    
    // 没有公共节点
    func testCase2()
    {
        let node7 = ListNode(value: 7, next: nil)
        let node6 = ListNode(value: 6, next: node7)
        let node5 = ListNode(value: 5, next: node6)
        let node4 = ListNode(value: 4, next: nil)
        let node3 = ListNode(value: 3, next: node4)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        
        XCTAssertEqual(nil, solution.findFirstCommonNode(node1, node5)?.value)
    }
    
    // 公共结点是最后一个结点
    func testCase3()
    {
        let node7 = ListNode(value: 7, next: nil)
        let node6 = ListNode(value: 6, next: node7)
        let node5 = ListNode(value: 5, next: node6)
        let node4 = ListNode(value: 4, next: node7)
        let node3 = ListNode(value: 3, next: node4)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        
        XCTAssertEqual(7, solution.findFirstCommonNode(node1, node5)?.value)
    }
    
    // 公共结点是第一个结点
    func testCase4()
    {
        let node5 = ListNode(value: 5, next: nil)
        let node4 = ListNode(value: 4, next: node5)
        let node3 = ListNode(value: 3, next: node4)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        
        XCTAssertEqual(1, solution.findFirstCommonNode(node1, node1)?.value)
    }
    
    // 输入的两个链表有一个空链表
    func testCase5()
    {
        let node5 = ListNode(value: 5, next: nil)
        let node4 = ListNode(value: 4, next: node5)
        let node3 = ListNode(value: 3, next: node4)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        
        XCTAssertEqual(nil, solution.findFirstCommonNode(node1, nil)?.value)
    }
}

UnitTests.defaultTestSuite.run()

