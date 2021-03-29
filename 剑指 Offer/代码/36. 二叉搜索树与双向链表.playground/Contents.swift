import Foundation
import XCTest

class BinaryTreeNode: Equatable
{
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    var value: Int
    
    init(value: Int, left: BinaryTreeNode?, right: BinaryTreeNode?)
    {
        self.value = value
        self.left = left
        self.right = right
    }
    
    static func ==(left: BinaryTreeNode, right: BinaryTreeNode) -> Bool
    {
        return left.value == right.value
    }
}

class Solution
{
    /**
     将二叉搜索树转换成一个排序的双向链表
     - Parameters:
        - rootNode: 二叉搜索树根节点
     - Returns: 双向排序链表头节点
     */
    func convertSearchTreeToDoublyList(_ rootNode: BinaryTreeNode) -> BinaryTreeNode?
    {
        // 指向双向链表的尾节点
        var lastNodeInList: BinaryTreeNode? = nil
        // 组装后的双向链表最后节点
        lastNodeInList = convertSearchTreeToDoublyListCore(lastNodeInList: lastNodeInList, treeNode: rootNode)
        
        // 需要返回的是双向链表的头节点而不是尾节点
        var headNode = lastNodeInList
        while headNode != nil && headNode!.left != nil
        {
            headNode = headNode!.left
        }
        return headNode
    }
    
    /**
     根据二叉搜索树节点组装双向排序链表
     - Parameters:
        - treeNode: 二叉搜索树节点
        - lastNodeInList: 当前双向链表的最后节点
     - Returns: 组装后的双向链表最后节点
     */
    private func convertSearchTreeToDoublyListCore(lastNodeInList: BinaryTreeNode?, treeNode: BinaryTreeNode?) -> BinaryTreeNode?
    {
        // 异常处理
        guard let treeNode = treeNode else {
            return nil
        }
        
        // 置为本地变量
        let currentNode = treeNode
        var lastNodeInList = lastNodeInList
        
        // 递归：当我们遍历转换到根节点时，它的左子树已经转换成一个排序的链表了，并且处在链表中的最后一个节点是当前值最大的节点
        if currentNode.left != nil
        {
            lastNodeInList = convertSearchTreeToDoublyListCore(lastNodeInList: lastNodeInList, treeNode: currentNode.left)
        }
        
        // 我们把值为8的节点和根节点链接起来，由于是双向链表所以需要互相连接
        currentNode.left = lastNodeInList
        if lastNodeInList != nil
        {
            lastNodeInList!.right = currentNode
        }
        
        // 此时链表中的最后一个节点就是10了
        lastNodeInList = currentNode
        
        // 接着我们去遍历转换右子树，并把根节点和右子树中最小的节点链接起来
        if currentNode.right != nil
        {
            lastNodeInList = convertSearchTreeToDoublyListCore(lastNodeInList: lastNodeInList, treeNode: currentNode.right)
        }
        
        return lastNodeInList
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
     验证双向链表的值
     - Parameters:
        - headNode: 双向链表头节点
        - values: 所有节点值组成的数组
     - Returns: 是否相同
     */
    private func isLinkedListValuesEqual(_ headNode: BinaryTreeNode?, values:[Int]) -> Bool
    {
        // 异常处理
        if headNode == nil && values.count > 0
        {
            return false
        }
        
        // 链表为空，数量为0这种情况为true哦
        if  headNode == nil && values.count == 0
        {
            return true
        }
        
        // 从头节点向后对比每个节点的值，倘若不相等则直接返回false
        var headNode = headNode!
        var index = 0
        while headNode.right != nil
        {
            if headNode.value != values[index]
            {
                return false
            }
            index += 1
            headNode = headNode.right!
        }
        
        // 上面对比完成后，头节点就变成尾节点了，此时再从尾节点向前对比每个节点的值，倘若不相等则直接返回false
        while headNode.left != nil
        {
            if headNode.value != values[index]
            {
                return false
            }
            index -= 1
            headNode = headNode.left!
        }
        
        return true
    }

    // 输入的二叉树是完全二叉树
    func testCase1()
    {
        let node_10 = BinaryTreeNode(value: 10, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node_14 = BinaryTreeNode(value: 14, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 8, left: nil, right: nil)
        let node_12 = BinaryTreeNode(value: 12, left: nil, right: nil)
        let node_16 = BinaryTreeNode(value: 16, left: nil, right: nil)
        node_10.left = node_6
        node_10.right = node_14
        node_6.left = node_4
        node_6.right = node_8
        node_14.left = node_12
        node_14.right = node_16
        
        let head = solution.convertSearchTreeToDoublyList(node_10)
        XCTAssertTrue(isLinkedListValuesEqual(head, values: [4,6,8,10,12,14,16]))
    }
    
    // 所有节点都没有左/右子树的二叉树
    func testCase2()
    {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, left: nil, right: nil)
        let node_1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        node_5.left = node_4
        node_4.left = node_3
        node_3.left = node_2
        node_2.left = node_1
        
        let head = solution.convertSearchTreeToDoublyList(node_5)
        XCTAssertTrue(isLinkedListValuesEqual(head, values: [1,2,3,4,5]))
    }

    // 所有节点都没有左/右子树的二叉树
    func testCase3()
    {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, left: nil, right: nil)
        let node_1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4
        node_4.right = node_5
        
        let head = solution.convertSearchTreeToDoublyList(node_1)
        XCTAssertTrue(isLinkedListValuesEqual(head, values: [1,2,3,4,5]))
    }
    
    // 只有一个节点的二叉树
    func testCase4()
    {
        let node_1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        let head = solution.convertSearchTreeToDoublyList(node_1)
        XCTAssertTrue(isLinkedListValuesEqual(head, values: [1]))
    }
}


UnitTests.defaultTestSuite.run()



