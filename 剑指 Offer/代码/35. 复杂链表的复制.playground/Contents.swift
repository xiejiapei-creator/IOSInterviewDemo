import Foundation
import XCTest

// 复杂链表结构
class ComplexListNode: Equatable
{
    var next: ComplexListNode?
    var sibling: ComplexListNode?
    var value: Int
    
    init(value: Int, next: ComplexListNode?, sibling: ComplexListNode?)
    {
        self.value = value
        self.next = next
        self.sibling = sibling
    }
    
    static func ==(left: ComplexListNode, right: ComplexListNode) -> Bool
    {
        return left.value == right.value
    }
}

class Solution
{
    /**
     复制复杂链表
     - Parameters:
        - head: 原始链表的头
     - Returns: 复制的链表头
     */
    func CopyComplexList(_ head: ComplexListNode) -> ComplexListNode
    {
        CloneNodes(head)
        ConnectSiblingNodes(head)
        return ReconnectNodes(head)
    }
    
    /**
     复制复杂链表，使得 A->B->C 变成 A->A'->B->B'->C->C' 暂不考虑 sibling
     - Parameters:
        - head: 链表的头
     */
    private func CloneNodes(_ head: ComplexListNode)
    {
        var node: ComplexListNode? = head
        while node != nil
        {
            let cloned = ComplexListNode(value: node!.value, next: node!.next, sibling: nil)
            node?.next = cloned
            node = cloned.next
        }
    }
    
    /**
     连接sibling，如果 A 的 sibling 是 C，那么 A‘ 的 sibling 必然是 C’ ，即 A.sibling.next
     - Parameters:
        - head: 链表的头
     */
    private func ConnectSiblingNodes(_ head: ComplexListNode)
    {
        var node: ComplexListNode? = head
        while node != nil
        {
            let cloned = node?.next
            if node?.sibling != nil
            {
                cloned?.sibling = node?.sibling?.next
            }
            node = cloned?.next
        }
    }
    
    /**
     分离两条合并在一起的复杂链表，使得 A->A'->B->B'->C->C' 编程两条链表 A->B->C 和 A'->B'->C'
     - Parameters:
        - head: 未分离的链表头
     - Returns: 复制出来的链表头
     */
    private func ReconnectNodes(_ head: ComplexListNode) -> ComplexListNode
    {
        var node: ComplexListNode? = head
        var clonedHead: ComplexListNode? = nil
        var clonedNode: ComplexListNode? = nil
        if node != nil
        {
            clonedHead = node!.next
            clonedNode = node!.next
            
            node?.next = clonedNode?.next
            node = node?.next
        }
        while node != nil
        {
            clonedNode?.next = node?.next
            clonedNode = clonedNode?.next
            
            node?.next = clonedNode?.next
            node = node?.next
        }
        return clonedHead!
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
    
    /**
     对比两条复杂链表结构以及值是否相同
     - Parameters:
        - left: 复杂链表1
        - right: 复杂链表2
     - Returns: 对比结果
     */
    private func isComplexListEqual(_ left: ComplexListNode, _ right: ComplexListNode) -> Bool
    {
        var node_left: ComplexListNode? = left
        var node_right: ComplexListNode? = right
        while node_left != nil && node_right != nil
        {
            if node_left!.value != node_left!.value
            {
                return false
            }
            if node_left!.sibling != nil && node_right!.sibling != nil
            {
                if node_left!.sibling!.value != node_left!.sibling!.value
                {
                    return false
                }
            }
            if node_left!.sibling == nil && node_left!.sibling != nil
            {
                return false
            }
            if node_left!.sibling != nil && node_left!.sibling == nil
            {
                return false
            }
            node_left = node_left!.next
            node_right = node_right!.next
        }
        if node_left == nil && node_right == nil
        {
            return true
        }
        return false
    }

    func testCase1()
    {
        let node5 = ComplexListNode(value: 5, next: nil, sibling: nil)
        let node4 = ComplexListNode(value: 4, next: node5, sibling: nil)
        let node3 = ComplexListNode(value: 3, next: node4, sibling: nil)
        let node2 = ComplexListNode(value: 2, next: node3, sibling: nil)
        let node1 = ComplexListNode(value: 1, next: node2, sibling: nil)
        node1.sibling = node3
        node2.sibling = node5
        node4.sibling = node2
        
        let clonedHead = solution.CopyComplexList(node1)
        XCTAssertEqual(isComplexListEqual(node1, clonedHead), true)
    }
    
    // Sibling指向结点自身
    func testCase2()
    {
        let node5 = ComplexListNode(value: 5, next: nil, sibling: nil)
        let node4 = ComplexListNode(value: 4, next: node5, sibling: nil)
        let node3 = ComplexListNode(value: 3, next: node4, sibling: nil)
        let node2 = ComplexListNode(value: 2, next: node3, sibling: nil)
        let node1 = ComplexListNode(value: 1, next: node2, sibling: nil)
        node2.sibling = node5
        node3.sibling = node3
        node4.sibling = node2
        
        let clonedHead = solution.CopyComplexList(node1)
        XCTAssertEqual(isComplexListEqual(node1, clonedHead), true)
    }
    
    // Sibling形成环
    func testCase3()
    {
        let node5 = ComplexListNode(value: 5, next: nil, sibling: nil)
        let node4 = ComplexListNode(value: 4, next: node5, sibling: nil)
        let node3 = ComplexListNode(value: 3, next: node4, sibling: nil)
        let node2 = ComplexListNode(value: 2, next: node3, sibling: nil)
        let node1 = ComplexListNode(value: 1, next: node2, sibling: nil)
        node2.sibling = node4
        node4.sibling = node2
        
        let clonedHead = solution.CopyComplexList(node1)
        XCTAssertEqual(isComplexListEqual(node1, clonedHead), true)
    }
    
    // 只有一个结点
    func testCase4()
    {
        let node1 = ComplexListNode(value: 1, next: nil, sibling: nil)
        
        let clonedHead = solution.CopyComplexList(node1)
        XCTAssertEqual(isComplexListEqual(node1, clonedHead), true)
    }
}

UnitTests.defaultTestSuite.run()
